import { IsEmail, IsNotEmpty } from "class-validator";
import CaptchaDto from "src/captcha/captcha.dto";
import { Serializable, JsonProperty } from "typescript-json-serializer";
import { PasswordRestrictions } from "src/shared/decorators/validation/password-restrictions.decorator";
import { UsernameRestrictions } from "src/shared/decorators/validation/username-restrictions.decorator";

@Serializable()
export default class RegisterDto extends CaptchaDto {
  @JsonProperty()
  @IsNotEmpty({
    message: "email-empty",
    context: { skipOthers: true },
  })
  @IsEmail(undefined, { message: "invalid-email" })
  public email: string;

  @JsonProperty()
  @UsernameRestrictions()
  public username: string;

  @JsonProperty()
  @PasswordRestrictions()
  public password: string;
}
