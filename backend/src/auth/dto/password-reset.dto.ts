import CaptchaDto from "src/captcha/captcha.dto";
import { IsNotEmpty } from "class-validator";
import { Serializable, JsonProperty } from "typescript-json-serializer";
import { PasswordRestrictions } from "src/shared/decorators/validation/password-restrictions.decorator";

@Serializable()
export default class PasswordResetDto extends CaptchaDto {
  @JsonProperty()
  @IsNotEmpty({
    message: "token-empty",
    context: { skipOthers: true },
  })
  public token: string;

  @JsonProperty()
  @PasswordRestrictions()
  public password: string;
}
