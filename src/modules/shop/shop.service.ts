import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectDataSource, InjectRepository } from '@nestjs/typeorm';
import { Categories, Products, SubCategories } from 'src/entity/shop.entity';
import { DataSource, Repository } from 'typeorm';

@Injectable()
export class ShopService {
    constructor(
        @InjectDataSource() private dataSource: DataSource,
        @InjectRepository(Categories) private readonly category: Repository<Categories>,
        @InjectRepository(SubCategories) private readonly subcategory: Repository<SubCategories>,
    ) { }

    async GetCategory() {
        try {
            // const data = await this.dataSource.query('select categories.name as name, sub_categories.name as sub from sub_categories full join categories on sub_categories."categoryId" = categories.id');
            const data = await this.dataSource.query(`select main,array_agg(sub) as sub
            from
                (select categories.name as main, sub_categories.name as sub 
                from categories 
                join sub_categories 
                    on categories.id = sub_categories."categoryId"
                ) temp_table
            group by main`)
            console.log(data);
            return data;
        } catch (error) {
            throw new BadRequestException("Server has something wrong");
        }
    }
}
