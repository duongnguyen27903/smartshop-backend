import { Controller, Get, ParseUUIDPipe, Query, UseGuards, Patch, Body, ParseIntPipe, Post, ValidationPipe } from '@nestjs/common';
import { AccountService } from './account.service';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { AuthGuard } from 'src/auth/auth.guard';
import { validate, ValidationTypes } from 'class-validator';

@ApiTags('account')
@ApiBearerAuth()
@UseGuards(AuthGuard)
@Controller('account')
export class AccountController {
  constructor(private readonly accountService: AccountService) { }

  @Get('get_current')
  async GetAccount(
    @Query('userId', ParseUUIDPipe) userId: string
  ) {
    return await this.accountService.get_payment_account(userId);
  }

  @Post('create_payment_account')
  async CreatePaymentAccount(
    @Query('userId', ParseUUIDPipe) userId: string,
    @Query('account_number',) account_number: string,
  ) {
    return await this.accountService.create_payment_account(userId, account_number);
  }

  @Patch('charge')
  async Charge(
    @Query('userId', ParseUUIDPipe) userId: string,
    @Query('amount', ParseIntPipe) amount: number
  ) {
    return await this.accountService.charge(userId, amount);
  }
}
