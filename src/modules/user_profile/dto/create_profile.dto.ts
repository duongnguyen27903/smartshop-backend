import { ApiProperty, PartialType } from "@nestjs/swagger";
import { IsUUID, MaxLength } from "class-validator";
import { Gender } from "src/entity/user.entity";

export class CreateProfileDto {
    @ApiProperty({ required: true })
    @IsUUID()
    userId: string
    @MaxLength(20)
    @ApiProperty({ required: true })
    first_name: string
    @MaxLength(20)
    @ApiProperty({ required: true })
    last_name: string
    @ApiProperty({ required: true })
    birthday: string
    @ApiProperty({ enum: Gender, required: true })
    gender: Gender
    @ApiProperty({ required: true })
    address: string
}

export class UpdateProfileDto extends PartialType(CreateProfileDto) { }