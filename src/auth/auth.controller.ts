import {
  Controller,
  Get,
  Post,
  Body,
  Query,
  UseGuards,
  ValidationPipe
} from '@nestjs/common';
import LoginDto from './dto/login.dto';
import SignUpDto from './dto/signup.dto';
import { ApiTags, ApiQuery, ApiBearerAuth } from '@nestjs/swagger';
import { AuthService } from './auth.service';
import { AuthGuard } from './auth.guard';
import { UserRole } from 'src/entity/user.entity';

@ApiTags('login')
@Controller({ path: ['auth'] })
export class AuthController {
  constructor(private readonly usersService: AuthService) { }

  @Post('login')
  async login(@Body() body: LoginDto) {
    return await this.usersService.login(body);
  }

  @Post('signup')
  @ApiQuery({ name: 'role', enum: UserRole })
  //ValidationPipe valide cac du lieu trong body voi cac quy tac trong signupdto
  async signup(@Body(new ValidationPipe()) body: SignUpDto, @Query('role') role: UserRole) {
    return await this.usersService.signup(body, role);
  }

  @ApiBearerAuth()
  @UseGuards(AuthGuard)
  @Get('test')
  async test() {
    return 'pass authentication'
  }
}
