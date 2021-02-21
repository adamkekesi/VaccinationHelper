import { ArrayMinSize, IsDate, IsNotEmpty } from "class-validator";
import { JsonProperty, Serializable } from "typescript-json-serializer";
import { Serializer } from "v8";

@Serializable()
export default class OfferAppointmentsDto {
  @JsonProperty()
  @IsNotEmpty({ message: "vaccinationId-empty" })
  public vaccinationId: string;

  @JsonProperty({ type: Date })
  @IsDate({ message: "offeredDates-invalid", each: true })
  @ArrayMinSize(1, { message: "offeredDates-min" })
  public offeredAppointments: Date[];
}
