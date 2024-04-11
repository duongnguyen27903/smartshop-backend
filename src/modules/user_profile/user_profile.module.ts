import { Module } from '@nestjs/common';
import { UserProfileService } from './user_profile.service';
import { UserProfileController } from './user_profile.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Profiles, Users } from 'src/entity/user.entity';
import { JwtModule } from '@nestjs/jwt';

@Module({
  imports: [TypeOrmModule.forFeature([Users, Profiles]), JwtModule],
  controllers: [UserProfileController],
  providers: [UserProfileService],
})
export class UserProfileModule { }
