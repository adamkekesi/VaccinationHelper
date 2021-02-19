import { ValidationOptions, registerDecorator, isAlpha } from "class-validator";

export function ContainsAlpha(
  amount = 1,
  validationOptions?: ValidationOptions
) {
  return (target: any, propertyName: string) => {
    registerDecorator({
      name: "containsAlpha",
      target: target.constructor,
      propertyName,
      constraints: [],
      options: validationOptions,
      validator: {
        validate(value: string) {
          if (typeof value !== "string") {
            return false;
          }
          var found = 0;
          value.split("").forEach((char) => {
            if (isAlpha(char, "hu-HU")) {
              found++;
            }
          });
          return found >= amount;
        },
      },
    });
  };
}
