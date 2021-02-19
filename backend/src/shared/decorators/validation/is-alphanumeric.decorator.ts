import {
  ValidationOptions,
  registerDecorator,
  isAlphanumeric
} from "class-validator";

export function IsAlphanumeric(
  locale?: string,
  validationOptions?: ValidationOptions
) {
  return (target: any, propertyName: string) => {
    registerDecorator({
      name: "isCustomAlphanumeric",
      target: target.constructor,
      propertyName,
      constraints: [],
      options: validationOptions,
      validator: {
        validate(value: string) {
          if (typeof value !== "string") {
            return false;
          }
          return value
            .split("")
            .every(char => char === " " || isAlphanumeric(char, locale as any));
        }
      }
    });
  };
}
