import {
  ValidationOptions,
  registerDecorator,
  isNumberString,
} from "class-validator";

export function ContainsNumbers(
  amount = 1,
  validationOptions?: ValidationOptions
) {
  return (target: any, propertyName: string) => {
    registerDecorator({
      name: "containsNumbers",
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
            if (isNumberString(char)) {
              found++;
            }
          });
          return found >= amount;
        },
      },
    });
  };
}
