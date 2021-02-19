import { MinLength, MaxLength, IsNotEmpty } from "class-validator";
import { ContainsSpecialCharacter } from "./contains-special-characters.decorator";
import { ContainsNumbers } from "./contains-numbers.decorator";
import { ContainsAlpha } from "./contains-alpha.decorator";

export function PasswordRestrictions() {
  return (target: any, propertyKey: string) => {
    IsNotEmpty({
      message: "password-empty",
      context: { skipOthers: true },
    })(target, propertyKey);
    MinLength(10, {
      message: "password-too-short",
    })(target, propertyKey);
    MaxLength(50, { message: "password-too-long" })(target, propertyKey);
    ContainsSpecialCharacter(2, {
      message: "password-not-contains-special-characters",
    })(target, propertyKey);
    ContainsNumbers(2, {
      message: "password-not-contains-numbers",
    })(target, propertyKey);
    ContainsAlpha(1, {
      message: "password-not-contains-letters",
    })(target, propertyKey);
  };
}
