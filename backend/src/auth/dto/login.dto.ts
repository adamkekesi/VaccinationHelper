import { IsNotEmpty } from "class-validator";
import CaptchaDto from "src/captcha/captcha.dto";
import { Serializable, JsonProperty } from "typescript-json-serializer";

@Serializable()
export default class LoginDto extends CaptchaDto {
  @JsonProperty()
  @IsNotEmpty({
    message: "username-empty",
    context: { skipOthers: true },
  })
  public username: string;

  @JsonProperty()
  @IsNotEmpty({
    message: "password-empty",
    context: { skipOthers: true },
  })
  public password: string;
}
