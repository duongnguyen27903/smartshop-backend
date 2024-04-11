import { ApiProperty } from "@nestjs/swagger";
import { IsNotEmpty, IsNumber, IsUUID } from "class-validator";

export class SaveCart {
    @IsNotEmpty()
    @IsUUID()
    @ApiProperty()
    userId: string
    @IsNotEmpty()
    @IsNumber()
    @ApiProperty()
    productId: number
    @IsNotEmpty()
    @IsNumber()
    @ApiProperty()
    amount: number
}