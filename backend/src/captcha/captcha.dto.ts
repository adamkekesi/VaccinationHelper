import { IsString, IsNotEmpty } from "class-validator";
import IpAddressDto from "../shared/dto/ip-address.dto.";
import { Serializable, JsonProperty } from "typescript-json-serializer";

@Serializable()
export default class CaptchaDto extends IpAddressDto {
  @IsNotEmpty({ message: "captcha-empty" })
  @JsonProperty()
  public captcha: string;
}
