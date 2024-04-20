import { ApiProperty, PartialType } from '@nestjs/swagger';
import { IsEmail, IsNotEmpty, IsUUID, Matches, MaxLength, MinLength } from 'class-validator';

export default class SignUpDto {
  @IsEmail()
  @ApiProperty({ required: true, example: 'user@gmail.com' })
  readonly email: string;

  @ApiProperty({ required: true })
  @IsNotEmpty()
  @MinLength(6)
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
  @Matches(/[0-9]{3}[0-9]{3}[0-9]{4}/, {
    message: "Phone number cannot contain text"
  })
  readonly phone_number: string;
}

export class UpdateUserDto extends PartialType(SignUpDto) {
  @ApiProperty()
  @IsUUID()
  id: string
}