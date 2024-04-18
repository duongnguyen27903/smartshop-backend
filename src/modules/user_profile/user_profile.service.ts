import { BadGatewayException, BadRequestException, Injectable } from '@nestjs/common';
import { InjectDataSource } from '@nestjs/typeorm';
import { DataSource } from 'typeorm';
import { CreateProfileDto, UpdateProfileDto } from './dto/create_profile.dto';
import { UpdateUserDto } from 'src/auth/dto/signup.dto';

@Injectable()
export class UserProfileService {
    constructor(
        @InjectDataSource() private dataSource: DataSource,

    ) { }

    async update_user(body: UpdateUserDto) {
        const { password, username, phone_number, id } = body;
        try {
            const update = await this.dataSource
                .query(`
                update users 
                set password = $1, username = $2, phone_number = $3 
                where id = $4 
                returning email,password,username,phone_number
            `, [password, username, phone_number, id]).then((val) => {
                    return val[0];
                })
            return update;
        } catch (error) {
            throw new error;
        }
    }

    async save_profile(body: UpdateProfileDto) {
        const { userId, first_name, last_name, gender, birthday, address } = body;
        try {
            const save = await this.dataSource
                .query(`insert into profiles(first_name,last_name,birthday,gender,address,"userId") 
                            values ($1,$2,$3,$4,$5,$6)
                        on conflict("userId")
                        do update 
                            set first_name = excluded.first_name,
                            last_name = excluded.last_name, 
                            birthday = excluded.birthday,
                            gender = excluded.gender,
                            address = excluded.address
                            returning *`
                    , [first_name, last_name, birthday, gender, address, userId]);
            return save;
        }
        catch (error) {
            console.log(error)
            throw new BadRequestException(error);
        }
    }

    async get_profile(id: string) {
        try {
            const data = await this.dataSource
                .query(`select p.first_name,p.last_name,p.birthday,p.gender,p.address 
                        from users as u 
                            left join profiles as p 
                                on u.id= p."userId" 
                                    where u.id = $1 `, [id]);
            return data;
        } catch (error) {
            throw new BadGatewayException();
        }
    }
}
