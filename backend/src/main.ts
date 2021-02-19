import initApplication from "./initApplication";

async function bootstrap() {
  var app = await initApplication();
  await app.listen(process.env.PORT || 3000);
}

bootstrap();
