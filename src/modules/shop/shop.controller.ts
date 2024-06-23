import { Controller, Get, Query, Req } from '@nestjs/common';
import { ShopService } from './shop.service';
import { ApiTags } from '@nestjs/swagger';
import { Request } from 'express';

@ApiTags('shop')
@Controller('api/shop')
export class ShopController {
  constructor(private readonly shopService: ShopService) { }

  @Get('get_categories')
  async get_categories() {
    return await this.shopService.GetCategory();
  }

  @Get('get_products')
  async get_products(
    @Query('id') id: number
  ) {
    return await this.shopService.GetProducts(id);
  }

  @Get('get_detail_product')
  async get_detail_product(
    @Query('id') id: number
  ) {
    return await this.shopService.GetDetailProduct(id);
  }
  @Get('get_best_seller')
  async get_best_seller(
    @Req() req: Request
  ) {
    console.log(req.hostname, ' ', req.path)
    return await this.shopService.GetBestSeller();
  }
}
