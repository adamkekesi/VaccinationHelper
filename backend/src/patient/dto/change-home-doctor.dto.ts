import { IsNotEmpty } from "class-validator";
import { JsonProperty, Serializable } from "typescript-json-serializer";

@Serializable()
export default class ChangeHomeDoctorDto {
  @JsonProperty()
  @IsNotEmpty({ message: "patientId-empty" })
  public patientId: string;

  @JsonProperty()
  @IsNotEmpty({ message: "doctorId-empty" })
  public doctorId: string;
}
