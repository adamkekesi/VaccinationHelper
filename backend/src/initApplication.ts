import { NestFactory } from "@nestjs/core";
import { AppModule } from "./app.module";
import { IpAddressInterceptor } from "./shared/interceptors/ip-address.interceptor";
import { SerializerInterceptor } from "./shared/interceptors/serializer.interceptor";
import {
  ExpressAdapter,
  NestExpressApplication,
} from "@nestjs/platform-express";

const cors = require("cors");

var app: NestExpressApplication;

export default async function initApplication(expressAdapter?: ExpressAdapter) {
  if (expressAdapter) {
    app = await NestFactory.create<NestExpressApplication>(
      AppModule,
      expressAdapter
    );
  } else {
    app = await NestFactory.create<NestExpressApplication>(AppModule);
  }
  app.useGlobalInterceptors(
    new SerializerInterceptor(),
    new IpAddressInterceptor()
  );
  app.use(cors());
  app.enableShutdownHooks();
  app.set("trust proxy", 1);
  app.setGlobalPrefix("api");

  return app;
}

export function getApp() {
  return app;
}
