import { Body, Controller, Get, Post, Query, UseGuards, ValidationPipe } from '@nestjs/common';
import { UserProfileService } from './user_profile.service';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { CreateProfileDto, UpdateProfileDto } from './dto/create_profile.dto';
import { AuthGuard } from 'src/auth/auth.guard';

@ApiTags("user_profile")
@ApiBearerAuth()
@UseGuards(AuthGuard)
@Controller('user-profile')
export class UserProfileController {
  constructor(private readonly userProfileService: UserProfileService) { }

  @Post("save-profile")
  async save_profile(@Body(new ValidationPipe) body: UpdateProfileDto) {
    return this.userProfileService.save_profile(body);
  }
  @Get('get-profile')
  async get_profile(
    @Query('id') id: string
  ) {
    return this.userProfileService.get_profile(id);
  }
}
