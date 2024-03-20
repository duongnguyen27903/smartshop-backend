import { Body, Controller, Post } from '@nestjs/common';
import { UserProfileService } from './user_profile.service';
import { ApiTags } from '@nestjs/swagger';
import { CreateProfileDto } from './dto/create_profile.dto';

@ApiTags("user_profile")
@Controller('user-profile')
export class UserProfileController {
  constructor(private readonly userProfileService: UserProfileService) { }

  @Post("create-profile")
  async create_profile(@Body() body: CreateProfileDto) {
    return this.userProfileService.create_profile(body);
  }
}
