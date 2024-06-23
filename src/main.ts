import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { CorsOptions } from '@nestjs/common/interfaces/external/cors-options.interface';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  const corsOptions: CorsOptions = {
    origin: (origin, callback) => {
      callback(null, true);
      return;
      // if (whitelist.indexOf(origin) !== -1 || !origin) {
      //   callback(null, true);
      // } else {
      //   // callback(new Error('Not allowed by CORS'));
      //   callback(null, false);
      // }
    },
  };
  // Enable CORS with the provided options
  app.enableCors(corsOptions);

  const config = new DocumentBuilder()
    .addBearerAuth()
    .setTitle(`SMARTSHOP`)
    .setDescription(`API SMARTSHOP ${process.env.NODE_ENV}`)
    .setVersion('1.0')
    .build();
  const document = SwaggerModule.createDocument(app, config, {});
  SwaggerModule.setup('api_list', app, document, {
    jsonDocumentUrl: 'smartshop.json',
  });

  await app.listen(process.env.NODE_ENV === 'production' ? Number(process.env.PORT_PROD) : Number(process.env.PORT_DEV));
}
bootstrap();
