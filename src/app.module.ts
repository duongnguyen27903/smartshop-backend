import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthModule } from './auth/auth.module';
import { Accounts, Profiles, TransactionHistories, Users } from './entity/user.entity';
import { UserProfileModule } from './modules/user_profile/user_profile.module';
import { Categories, Products, SubCategories } from './entity/shop.entity';
import { ShopModule } from './modules/shop/shop.module';


@Module({
  imports: [
    ConfigModule.forRoot({
      envFilePath: '.env',
      isGlobal: true,
    }),
    TypeOrmModule.forRoot({
      type: 'postgres',
      port: 5432,
      host: process.env.DB_HOST,
      username: process.env.DB_USER,
      password: process.env.DB_PASS,
      database: process.env.DB_NAME,
      entities: [Users, Profiles, Accounts, TransactionHistories, Categories, Products, SubCategories],
      keepConnectionAlive: true,
      synchronize: true,
      autoLoadEntities: true,
    }),
    AuthModule,
    UserProfileModule,
    ShopModule
  ],
})
export class AppModule { }
