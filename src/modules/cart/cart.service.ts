import { BadGatewayException, BadRequestException, Injectable } from '@nestjs/common';
import { InjectDataSource } from '@nestjs/typeorm';
import { DataSource } from 'typeorm';
import { SaveCart } from './dto/save_cart.dto';

@Injectable()
export class CartService {
    constructor(
        @InjectDataSource() private dataSource: DataSource
    ) { }


    // //design table cũ
    // async get_cart(id: string) {
    //     try {
    //         const data = await this.dataSource
    //             .query(`select cast(cart.amount as integer),p.id,p.name,p.price,p."brandId",p.image from
    //                     (select temp.p->>'id' as id, temp.p->>'amount' as amount 
    //                         from (select jsonb_array_elements(store) as p 
    //                                 from carts 
    //                                 where carts."userId" = $1) as temp ) 
    //                             as cart 
    //                     inner join products as p 
    //                     on p.id = cast(cart.id as integer)`, [id])
    //         return data;
    //     } catch (error) {
    //         throw new BadGatewayException();
    //     }
    // }

    async get_cart(id: string) {
        try {
            const data = await this.dataSource
                .query(`select c.id as cart_id,c.amount,p.id,p.name,p.price,p."brandId",p.image from carts as c 
                        inner join products as p on p.id = c."productId"
                        inner join users as u on u.id = c."userId"
                        where c."userId" = $1`, [id])
            return data;
        } catch (error) {
            throw new BadGatewayException();
        }
    }

    async save_cart(save_cart: SaveCart) {
        const { userId, productId, amount } = save_cart;
        try {
            const check = await this.dataSource.query(`select available_quantity as quantity from products where id=$1`, [productId]);
            if (amount <= 0) {
                throw new BadRequestException({ message: "Increase your quantity" });

            }
            if (amount > check[0].quantity) {
                throw new BadRequestException({ message: "Decrease your quantity" });
            }

            const save = await this.dataSource
                .query(`insert into carts("productId","userId",amount) values ($1,$2,$3)
                on conflict ("productId","userId")
                do update set amount = excluded.amount
                returning *`, [productId, userId, amount])
            return {
                message: "Add product to your cart successfully"
            };
        } catch (error) {
            throw new BadGatewayException();
        }
    }

    async delete_cart(id: number, user: string) {
        try {
            const check = await this.dataSource
                .query(`select 
            exists( select * from carts 
                where "userId"=$1 and id = $2)`, [user, id]);
            if (!check[0].exists) {
                throw new BadRequestException({ message: "Not found" });
            }
            const del = await this.dataSource.query(`delete from carts where id = $1 returning *`, [id]);
            return {
                message: "Delete successfully"
            }
        } catch (error) {
            throw new BadGatewayException();
        }
    }
}
