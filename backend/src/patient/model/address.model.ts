import { Column } from "typeorm";
import { JsonProperty, Serializable } from "typescript-json-serializer";

@Serializable()
export default class AddressModel {
  @JsonProperty()
  @Column()
  public zipCode: string;

  @JsonProperty()
  @Column()
  public city: string;

  @JsonProperty()
  @Column()
  public address: string;

  constructor(zipCode: string, city: string, address: string) {
    this.zipCode = zipCode;
    this.city = city;
    this.address = address;
  }
}
