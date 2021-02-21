import { IsNotEmpty, isNotEmpty } from "class-validator";
import { JsonProperty, Serializable } from "typescript-json-serializer";
import { Serializer } from "v8";

@Serializable()
export default class ChooseVaccinatorDto {
  @JsonProperty()
  @IsNotEmpty({ message: "vaccinationId-empty" })
  public vaccinationId: string;

  @JsonProperty()
  @IsNotEmpty({ message: "vaccinatorId-empty" })
  public vaccinatorId: string;
}
