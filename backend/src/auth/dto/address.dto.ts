import { IsNotEmpty, IsNumberString, MaxLength } from "class-validator";
import { JsonProperty, Serializable } from "typescript-json-serializer";

@Serializable()
export default class AddressDto {
  @JsonProperty()
  @IsNotEmpty({
    message: "zipCode-empty",

    context: { skipOthers: true },
  })
  @MaxLength(4, { message: "zipCode-too-long" })
  @IsNumberString({ no_symbols: true }, {})
  public zipCode: string;

  @JsonProperty()
  @IsNotEmpty({
    message: "city-empty",
    context: { skipOthers: true },
  })
  public city: string;

  @JsonProperty()
  @IsNotEmpty({
    message: "address-empty",
    context: { skipOthers: true },
  })
  public address: string;
}
