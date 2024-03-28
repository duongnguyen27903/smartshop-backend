import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsNotEmpty, Matches, MaxLength, MinLength } from 'class-validator';

export default class SignUpDto {
  @IsEmail()
  @ApiProperty({ required: true, example: 'user@gmail.com' })
  readonly email: string;

  @ApiProperty({ required: true })
  @IsNotEmpty()
  // @MinLength(8)
  // @MaxLength(20)
  // @Matches(/((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$/, {
  //   message: 'password too weak',
  // })
  readonly password: string;

  @ApiProperty({ required: true })
  @IsNotEmpty()
  @MaxLength(30)
  readonly username: string;

  @ApiProperty()
  @MaxLength(16)

  readonly phone_number: string;
}
