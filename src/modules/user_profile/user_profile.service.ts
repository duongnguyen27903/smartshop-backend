import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Profiles, Users } from 'src/entity/user.entity';
import { Repository } from 'typeorm';
import { CreateProfileDto } from './dto/create_profile.dto';
import { log } from 'console';

@Injectable()
export class UserProfileService {
    constructor(
        @InjectRepository(Profiles) private profile: Repository<Profiles>,
        @InjectRepository(Users) private user: Repository<Users>
    ) { }

    async create_profile(body: CreateProfileDto) {
        const { id, first_name, last_name, gender, birthday, address } = body;
        const user = await this.profile.query('select * from users where id=$1', [id]);
        if (!user) {
            return new BadRequestException("Your account is not exist");
        }
        if (user[0].profileId) {
            try {
                log("update");
                const update_profile = await this.profile.query('update profile set first_name=$1,last_name=$2,address=$3,birthday=$4,gender=$5 where id=$6', [first_name, last_name, address, birthday, gender, user[0].profileId]);
                log(update_profile[0].id);
            } catch (error) {
                throw error;
            }
        }
        else {
            try {
                log("add");
                const insert_profile = await this.profile.query('insert into profile(first_name,last_name,address,birthday,gender) values($1,$2,$3,$4,$5)', [first_name, last_name, address, birthday, gender]);
                log(insert_profile);
                // const update_user = await this.profile.query('update users set "profileId"=$1 where id=$2 '[insert_profile.id, user.id]);
                // Promise.all([insert_profile, update_user]);
            } catch (error) {
                throw error;
            }
        }
        return user;
    }
}
