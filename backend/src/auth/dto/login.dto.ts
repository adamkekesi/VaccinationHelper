import { IsNotEmpty } from "class-validator";
import { Serializable, JsonProperty } from "typescript-json-serializer";

@Serializable()
export default class LoginDto {
  @JsonProperty()
  @IsNotEmpty({
    message: "email-empty",
    context: { skipOthers: true },
  })
  public email: string;

  @JsonProperty()
  @IsNotEmpty({
    message: "password-empty",
    context: { skipOthers: true },
  })
  public password: string;
}
