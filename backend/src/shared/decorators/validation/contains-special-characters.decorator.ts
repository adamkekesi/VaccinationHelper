import {
  ValidationOptions,
  registerDecorator,
  isAlphanumeric
} from "class-validator";

export function ContainsSpecialCharacter(
  amount = 1,
  validationOptions?: ValidationOptions
) {
  return (target: any, propertyName: string) => {
    registerDecorator({
      name: "containsSpecialCharacter",
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
          value.split("").forEach(char => {
            if (!isAlphanumeric(char, "hu-HU") && char !== " ") {
              found++;
            }
          });
          return found >= amount;
        }
      }
    });
  };
}
