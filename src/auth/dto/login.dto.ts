import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsNotEmpty } from 'class-validator';

export default class LoginDto {
  @IsEmail()
  @ApiProperty({ required: true, example: 'user@gmail.com' })
  readonly email: string;

  @IsNotEmpty()
  @ApiProperty({ required: true, example: '123456' })
  readonly password: string;
}
