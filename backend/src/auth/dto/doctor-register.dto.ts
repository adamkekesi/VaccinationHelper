import {
  IsBoolean,
  IsDate,
  IsEmail,
  IsNotEmpty,
  IsPhoneNumber,
  MaxLength,
} from "class-validator";
import { Serializable, JsonProperty } from "typescript-json-serializer";
import { PasswordRestrictions } from "src/shared/decorators/validation/password-restrictions.decorator";

@Serializable()
export default class DoctorRegisterDto {
  @JsonProperty()
  @IsNotEmpty({
    message: "fullName-empty",
    context: { skipOthers: true },
  })
  public fullName: string;

  @JsonProperty()
  @IsNotEmpty({
    message: "email-empty",
    context: { skipOthers: true },
  })
  @IsEmail(undefined, { message: "invalid-email" })
  public email: string;

  @JsonProperty()
  @IsNotEmpty({
    message: "phoneNumber-empty",
    context: { skipOthers: true },
  })
  @IsPhoneNumber("HU", { message: "phoneNumber-invalid" })
  public phoneNumber: string;

  @JsonProperty()
  @IsNotEmpty({
    message: "city-empty",
    context: { skipOthers: true },
  })
  public city: string;

  @JsonProperty()
  @PasswordRestrictions()
  public password: string;

  @JsonProperty()
  @IsBoolean({ message: "isHomeDoctor-invalid" })
  public isHomeDoctor: boolean;

  @JsonProperty()
  @IsBoolean({ message: "isVaccinatorDoctor-invalid" })
  public isVaccinatorDoctor: boolean;
}
