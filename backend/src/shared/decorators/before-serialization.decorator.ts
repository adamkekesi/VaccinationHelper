import { NestInterceptor, Type } from "@nestjs/common";

export function BeforeSerialization(...interceptors: Type<NestInterceptor>[]) {
  return (target: any, propertyKey: string, descriptor: PropertyDescriptor) => {
    Reflect.defineMetadata(
      "beforeSerialization",
      interceptors,
      target,
      propertyKey
    );
  };
}
