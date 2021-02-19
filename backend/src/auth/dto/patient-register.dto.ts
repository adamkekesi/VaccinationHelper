import {
  IsDate,
  IsEmail,
  IsNotEmpty,
  IsPhoneNumber,
  MaxLength,
} from "class-validator";
import { Serializable, JsonProperty } from "typescript-json-serializer";
import { PasswordRestrictions } from "src/shared/decorators/validation/password-restrictions.decorator";
import AddressDto from "./address.dto";

@Serializable()
export default class PatientRegisterDto {
  @JsonProperty()
  @IsNotEmpty({
    message: "fullName-empty",
    context: { skipOthers: true },
  })
  public fullName: string;

  @JsonProperty()
  @IsNotEmpty({
    message: "address-empty",
    context: { skipOthers: true },
  })
  public address: AddressDto;

  @JsonProperty()
  @IsNotEmpty({
    message: "dateOfBirth-empty",
    context: { skipOthers: true },
  })
  @IsDate({ message: "dateOfBirth-not-date" })
  public dateOfBirth: Date;

  @JsonProperty()
  @IsNotEmpty({
    message: "email-empty",
    context: { skipOthers: true },
  })
  @IsEmail(undefined, { message: "invalid-email" })
  public email: string;

  @JsonProperty()
  @IsNotEmpty({
    message: "identityCardNumber-empty",
    context: { skipOthers: true },
  })
  @MaxLength(12, { message: "identityCardNumber-too-long" })
  public identityCardNumber: string;

  @JsonProperty()
  @IsNotEmpty({
    message: "ssn-empty",
    context: { skipOthers: true },
  })
  @MaxLength(12, { message: "ssn-too-long" })
  public ssn: string;

  @JsonProperty()
  @IsNotEmpty({
    message: "phoneNumber-empty",
    context: { skipOthers: true },
  })
  @IsPhoneNumber("HU", { message: "phoneNumber-invalid" })
  public phoneNumber: string;

  @JsonProperty()
  @PasswordRestrictions()
  public password: string;
}
