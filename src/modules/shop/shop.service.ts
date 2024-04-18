import { BadGatewayException, BadRequestException, Injectable } from '@nestjs/common';
import { InjectDataSource } from '@nestjs/typeorm';
import { DataSource } from 'typeorm';

@Injectable()
export class ShopService {
    constructor(
        @InjectDataSource() private dataSource: DataSource,
    ) { }
    private readonly ServerError = "Server has something wrong, please try again!"

    async GetCategory() {
        try {
            //query tất cả các types và brands có trong products, 
            const data = await this.dataSource
                .query(`select main,array_agg(sub) as sub from 
                            (select car_types.name as main, jsonb_build_object('id',brands.id,'name',brands.name) as sub from car_types 
                                inner join brands 
                                    on brands."typeId" = car_types.id 
                                        where brands.id 
                                    in ( select distinct("brandId") from products ) ) as temp group by main`);
            return data;
        } catch (error) {
            throw error;
        }
    }

    async GetProducts(id: number) {
        try {
            // query tất cả các sản phẩm có trong products có brandId
            const data = await this.dataSource
                .query(`select id,name,image,price 
                    from products 
                    where "brandId"=$1 
                    order by price asc`, [id]);
            return data;
        } catch (error) {
            throw error;
        }
    }

    async GetDetailProduct(id: number) {
        try {
            //query chi tiết sản phẩm
            const data = await this.dataSource
                .query(`select products.id,products.description,products.price,products.name,products.quantity,products.image,users.username,users.email,users.phone_number,brands.name as brand_name 
                            from products 
                            inner join users on products."userId" = users.id
				            inner join brands on products."brandId"= brands.id
                                where products.id=$1`, [id])
            return data;
        } catch (error) {
            throw error;
        }
    }

    async GetBestSeller() {
        try {
            const best_sellers = await this.dataSource.query(`
            with bill as (
                select "productId" as id,sum(amount) as sold
                from bills 
                group by "productId" having sum(amount) > 2 order by sold desc
            ),
            product as (
                select p.id, p.name,p.quantity,p.image,p.price,b.id as brandId from products as p left join brands as b on p."brandId" = b.id
            )
            select id,p.name,p.image,p.brandId as brandId from bill left join product as p using(id) limit 10`)
            let start = 0
            let data = best_sellers.map((val: any) => {
                return { ...val, identity: start++ }
            })
            return data;
        } catch (error) {
            throw new error;
        }
    }
}
