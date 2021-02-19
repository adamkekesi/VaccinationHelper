import CaptchaDto from "src/captcha/captcha.dto";
import { IsEmail, IsNotEmpty } from "class-validator";
import { Serializable, JsonProperty } from "typescript-json-serializer";

@Serializable()
export default class EmailVerificationRequestDto extends CaptchaDto {
  @JsonProperty()
  @IsNotEmpty({
    message: "email-empty",
    context: { skipOthers: true },
  })
  @IsEmail(undefined, { message: "invalid-email" })
  public email: string;
}
