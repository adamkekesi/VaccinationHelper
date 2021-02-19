import CaptchaDto from "src/captcha/captcha.dto";
import { IsNotEmpty } from "class-validator";
import { Serializable, JsonProperty } from "typescript-json-serializer";

@Serializable()
export default class EmailVerificationDto extends CaptchaDto {
  @JsonProperty()
  @IsNotEmpty({
    message: "token-empty",
    context: { skipOthers: true },
  })
  public token: string;
}
