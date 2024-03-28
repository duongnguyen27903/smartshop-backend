import { Module } from '@nestjs/common';
import { ShopService } from './shop.service';
import { ShopController } from './shop.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Brands, CarTypes, Products } from 'src/entity/shop.entity';

@Module({
  imports: [TypeOrmModule.forFeature([CarTypes, Brands, Products])],
  controllers: [ShopController],
  providers: [ShopService],
})
export class ShopModule { }
