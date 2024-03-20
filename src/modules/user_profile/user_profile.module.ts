import { Module } from '@nestjs/common';
import { UserProfileService } from './user_profile.service';
import { UserProfileController } from './user_profile.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Profiles, Users } from 'src/entity/user.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Users, Profiles])],
  controllers: [UserProfileController],
  providers: [UserProfileService],
})
export class UserProfileModule { }
