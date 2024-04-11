import { Body, Controller, Delete, Get, ParseIntPipe, ParseUUIDPipe, Post, Query, UseGuards, ValidationPipe } from '@nestjs/common';
import { CartService } from './cart.service';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { AuthGuard } from 'src/auth/auth.guard';
import { SaveCart } from './dto/save_cart.dto';

@ApiTags('cart')
@ApiBearerAuth()
@UseGuards(AuthGuard)
@Controller('cart')
export class CartController {
  constructor(private readonly cartService: CartService) { }

  @Get('get_cart')
  async GetCart(
    @Query('id') id: string
  ) {
    return await this.cartService.get_cart(id);
  }

  @Post('save_cart')
  async SaveCart(
    @Body(new ValidationPipe()) body: SaveCart
  ) {
    return await this.cartService.save_cart(body)
  }

  @Delete('delete_cart')
  async DeleteCart(
    @Query('id', ParseIntPipe) id: number,
    @Query('user', ParseUUIDPipe) user: string
  ) {
    return await this.cartService.delete_cart(id, user);
  }
}
