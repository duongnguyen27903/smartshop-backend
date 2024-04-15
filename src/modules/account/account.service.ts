import { BadGatewayException, BadRequestException, Injectable } from '@nestjs/common';
import { InjectDataSource, InjectEntityManager } from '@nestjs/typeorm';
import { DataSource, EntityManager } from 'typeorm';
import { CreateTransactionDto } from './dto/CreateTransactionDto.dto';

@Injectable()
export class AccountService {
    constructor(
        @InjectDataSource() private dataSource: DataSource,
        @InjectEntityManager() private manager: EntityManager
    ) { }

    async get_payment_account(userId: string) {
        try {
            const data = await this.dataSource
                .query(`select account_number,account_balance 
                    from accounts 
                    where "userId" = $1`, [userId])
            return data;
        } catch (error) {
            throw new BadGatewayException();
        }
    }

    async create_payment_account(userId: string, account_number: string) {
        try {
            const regex = /^[0-9]{12}$/g;
            if (account_number.search(regex) == -1) {
                throw new BadRequestException();
            }
            const new_account = await this.dataSource
                .query(`insert into accounts("userId",account_number) 
                values ($1,$2)`, [userId, account_number])
            return {
                message: "Successful"
            }
        } catch (error) {
            throw new BadGatewayException();
        }
    }



    async charge(userId: string, amount: number) {
        try {
            const add_money = await this.dataSource
                .query(`update accounts 
            set account_balance = account_balance + $1 
            where "userId" = $2`, [amount, userId])
            return 1;
        } catch (error) {
            throw new BadGatewayException();
        }
    }

    async BuyProduct(body: CreateTransactionDto) {
        const { userId, productId, product_amount } = body;
        try {
            const check_user = await this.dataSource
                .query(`select account_number,account_balance from accounts where "userId"=$1 and "isActive"=true`, [userId]);
            if (!check_user || check_user.length == 0) {
                throw new BadRequestException('Please create your payment account')
            }

            const check_product = await this.dataSource
                .query(`select id,quantity,price,"userId" 
                from products 
                where id=$1 `,
                    [productId])

            const cost = check_product[0].price * product_amount;
            if (!check_product || check_product.length == 0) {
                throw new BadRequestException("No product found");
            }
            else if (check_product[0].userId === userId) {
                throw new BadRequestException("Something wrong happened")
            }
            else if (check_product[0].quantity < product_amount) {
                throw new BadRequestException("Decrease your product")
            }
            else if (cost > check_user[0]?.account_balance) {
                throw new BadRequestException("Not enough money")
            }

            try {
                // const connection = this.manager.connection;
                const queryRunner = this.dataSource.createQueryRunner()

                // establish real database connection using our new query runner
                await queryRunner.connect()



                // lets now open a new transaction:
                await queryRunner.startTransaction()

                try {
                    // execute some operations on this transaction:

                    queryRunner.query(`update products set quantity = quantity - $1 where id = $2;`, [product_amount, productId]);

                    queryRunner
                        .query(`
                    with bill as ( 
                        insert into bills(amount,cost,"productId",account_number) 
                        values ( $1,$3,$2,$4)
                        returning *
                    ),
                    product as (
                        select products.name as pname,users.username as username from products left join users on products."userId" = users.id where products.id = $2
                    ),
                    host_account as (
                        update accounts set account_balance = account_balance + $3 where "userId" = $5 returning *
                    ),
                    customer_account as (
                        update accounts set account_balance = account_balance - $3 where "userId" = $6 returning *
                    ),
                    customer as (
                        select username from users where id = $6
                    ),
                    buy_note as (
                        select format('Buy %s %I from %L ',$1,(select product.pname from product),(select username from product)) as note
                    ),
                    sell_note as (
                        select format('Sell %s %I to %L ',$1,(select product.pname from product),(select username from customer)) as note
                    ),
                    new_transaction as (
                        select 
                        CAST('buy' as transaction_histories_action_enum ) as action, ( select note from buy_note ) as note , -$3 as amount, (select account_number from customer_account) as account_number , (select account_number from host_account) as "from", (select id from bill) as "billId"
                        union all 
                        select CAST('sell' as transaction_histories_action_enum ),( select note from sell_note ),$3,(select account_number from host_account),(select account_number from customer_account),(select id from bill)
                    )
                    
                    insert into transaction_histories( action, note , amount, account_number, "from", "billId" )
                    select * from new_transaction;

                `, [product_amount, productId, cost, check_user[0].account_number, check_product[0].userId, userId],)

                    // commit transaction now:
                    await queryRunner.commitTransaction()
                } catch (err) {
                    // since we have errors let's rollback changes we made
                    await queryRunner.rollbackTransaction()
                } finally {
                    // you need to release query runner which is manually created:
                    await queryRunner.release()
                }

                // const transaction = await this.dataSource
                //     .query(`
                //     begin;
                //     update products set quantity = quantity - $1 where id = $2;
                //     with bill as ( 
                //         insert into bills(amount,cost,"productId",account_number) 
                //         values ( $1,$3,$2,$4)
                //         returning *
                //     ),
                //     product as (
                //         select products.name as pname,users.username as username from products left join users on products."userId" = users.id where products.id = $1
                //     ),
                //     host_account as (
                //         update accounts set account_balance = account_balance + $3 where "userId" = $5 returning *
                //     ),
                //     customer_account as (
                //         update accounts set account_balance = account_balance - $3 where "userId" = $6 returning *
                //     ),
                //     customer as (
                //         select username from users where id = $6
                //     ),
                //     new_transaction as (
                //         select 
                //         CAST('buy' as transaction_histories_action_enum ) as action, -$3 as amount, (select account_number from customer_account) as account_number , (select account_number from host_account) as "from", (select id from bill) as "billId"
                //         union all 
                //         select CAST('sell' as transaction_histories_action_enum ),$3 as amount,(select account_number from host_account),(select account_number from customer_account),(select id from bill)
                //     )

                //     insert into transaction_histories( action, amount, account_number, "from", "billId" )
                //     select * from new_transaction;

                //     commit;
                // `, [product_amount, productId, cost, check_user[0].account_number, check_product[0].userId, userId],)
                return "Successful";
            } catch (error) {
                throw error;
            }

        } catch (error) {
            throw error;
        }
    }
}
