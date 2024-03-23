import { Module } from '@nestjs/common';
import { ShopService } from './shop.service';
import { ShopController } from './shop.controller';
import { Categories, Products, SubCategories } from 'src/entity/shop.entity';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [TypeOrmModule.forFeature([Categories, Products, SubCategories])],
  controllers: [ShopController],
  providers: [ShopService],
})
export class ShopModule { }
