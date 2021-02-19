import { ValidationOptions, registerDecorator } from "class-validator";

export function NotContainsControlCharacters(
  validationOptions?: ValidationOptions
) {
  return (target: any, propertyName: string) => {
    registerDecorator({
      name: "notContainsControlCharacters",
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
            .every(
              (char) =>
                ![" ", "\b", "\f", "\n", "\r", "\t", "\v", "\0"].includes(char)
            );
        },
      },
    });
  };
}
