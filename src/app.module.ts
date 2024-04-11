import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthModule } from './auth/auth.module';
import { Accounts, Carts, Profiles, TransactionHistories, Users } from './entity/user.entity';
import { UserProfileModule } from './modules/user_profile/user_profile.module';
import { CarTypes, Products, Brands } from './entity/shop.entity';
import { ShopModule } from './modules/shop/shop.module';
import { CartModule } from './modules/cart/cart.module';
import { AccountModule } from './modules/account/account.module';


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
      entities: [Users, Profiles, Accounts, TransactionHistories, CarTypes, Products, Brands, Carts],
      keepConnectionAlive: true,
      synchronize: true,
      autoLoadEntities: true,
    }),
    AuthModule,
    UserProfileModule,
    ShopModule,
    CartModule,
    AccountModule
  ],
})
export class AppModule { }
