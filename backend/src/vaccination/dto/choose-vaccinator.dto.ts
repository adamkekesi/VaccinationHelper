import { IsNotEmpty } from "class-validator";
import { JsonProperty, Serializable } from "typescript-json-serializer";

@Serializable()
export default class ChooseVaccinatorDto {
  @JsonProperty()
  @IsNotEmpty({ message: "vaccinationId-empty" })
  public vaccinationId: string;

  @JsonProperty()
  @IsNotEmpty({ message: "vaccinatorId-empty" })
  public vaccinatorId: string;
}
