import { BadGatewayException, BadRequestException, Injectable } from '@nestjs/common';
import { InjectDataSource } from '@nestjs/typeorm';
import { DataSource } from 'typeorm';

@Injectable()
export class AccountService {
    constructor(
        @InjectDataSource() private dataSource: DataSource
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
}
