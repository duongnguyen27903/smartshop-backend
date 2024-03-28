import { BadGatewayException, BadRequestException, Injectable } from '@nestjs/common';
import { InjectDataSource } from '@nestjs/typeorm';
import { DataSource } from 'typeorm';

@Injectable()
export class ShopService {
    constructor(
        @InjectDataSource() private dataSource: DataSource,

    ) {

    }
    private readonly ServerError = "Server has something wrong, please try again!"

    async GetCategory() {
        try {
            const data = await this.dataSource
                .query(`select main,array_agg(sub) as sub 
            from 
                (select car_types.name as main, jsonb_build_object('id',brands.id,'name',brands.name) as sub 
                    from car_types 
                        right join brands 
                            on car_types.id = brands."typeId") temp
            group by main`);
            return data;
        } catch (error) {
            throw new BadGatewayException(this.ServerError);
        }
    }

    async GetProducts(id: number) {
        try {
            const data = await this.dataSource
                .query(`select id,name,image,price 
                    from products 
                    where "brandId"=$1 
                    order by price asc`, [id]);
            return data;
        } catch (error) {
            throw new BadGatewayException(this.ServerError);
        }
    }

    async GetDetailProduct(id: number) {
        try {
            const data = await this.dataSource
                .query(`select products.id,products.description,products.price,products.name,products.available_quantity,products.image,users.username,users.email,users.phone_number 
                from products 
                left join users 
                    on products."userId" = users.id 
                        where products.id=$1`, [id])
            return data;
        } catch (error) {
            throw new BadGatewayException(this.ServerError);
        }
    }
}
