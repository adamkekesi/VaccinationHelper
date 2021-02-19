import { MinLength, MaxLength, IsNotEmpty } from "class-validator";
import { NotContainsControlCharacters } from "./not-contains-control-characters.decorator";

export function UsernameRestrictions() {
  return (target: any, propertyKey: string) => {
    IsNotEmpty({
      message: "username-empty",
      context: { skipOthers: true },
    })(target, propertyKey);
    MinLength(4, {
      message: "username-too-short",
    })(target, propertyKey);
    MaxLength(30, {
      message: "username-too-long",
    })(target, propertyKey);
    NotContainsControlCharacters({
      message: "username-contains-control-characters",
    })(target, propertyKey);
  };
}
