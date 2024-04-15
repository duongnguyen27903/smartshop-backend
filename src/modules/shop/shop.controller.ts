import { Body, Controller, Get, Post, Query, ValidationPipe } from '@nestjs/common';
import { ShopService } from './shop.service';
import { ApiTags } from '@nestjs/swagger';
import { CreateTransactionDto } from '../account/dto/CreateTransactionDto.dto';

@ApiTags('shop')
@Controller('shop')
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
}
