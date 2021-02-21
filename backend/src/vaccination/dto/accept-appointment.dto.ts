import { IsDate, IsNotEmpty } from "class-validator";
import { JsonProperty, Serializable } from "typescript-json-serializer";

@Serializable()
export default class AcceptAppointmentDto {
  @JsonProperty()
  @IsDate({ message: "chosenDate-invalid" })
  public chosen: Date;

  @JsonProperty()
  @IsNotEmpty({ message: "vaccinationId-empty" })
  public vaccinationId: string;
}
