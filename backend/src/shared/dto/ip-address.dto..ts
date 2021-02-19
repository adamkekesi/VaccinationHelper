import { Serializable, JsonProperty } from "typescript-json-serializer";

@Serializable()
export default class IpAddressDto {
  @JsonProperty()
  public ipAddress: string;
}
