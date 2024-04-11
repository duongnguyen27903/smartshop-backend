import { BadGatewayException, BadRequestException, Injectable } from '@nestjs/common';
import { InjectDataSource } from '@nestjs/typeorm';
import { DataSource } from 'typeorm';
import { CreateProfileDto, UpdateProfileDto } from './dto/create_profile.dto';

@Injectable()
export class UserProfileService {
    constructor(
        @InjectDataSource() private dataSource: DataSource,

    ) { }

    async save_profile(body: UpdateProfileDto) {
        const update_profile_key = Object.keys(body);
        const update_profile_value = Object.values(body);
        console.log()
        const { id, first_name, last_name, gender, birthday, address } = body;
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
                    , [first_name, last_name, gender, birthday, address, id]);
            return save;
        }
        catch (error) {
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
