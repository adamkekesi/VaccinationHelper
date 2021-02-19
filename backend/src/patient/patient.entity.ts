import UserEntity from "src/user/user.entity";
import { ChildEntity, Column, Entity } from "typeorm";
import { JsonProperty, Serializable } from "typescript-json-serializer";
import AddressModel from "./address.model";

@ChildEntity()
@Serializable()
export default class PatientEntity extends UserEntity {
  @Column(() => AddressModel)
  @JsonProperty()
  public address: AddressModel;

  @JsonProperty()
  @Column()
  public dateOfBirth: Date;

  @JsonProperty()
  @Column()
  public identityCardNumber: string;

  @JsonProperty()
  @Column()
  public ssn: string;

  constructor(
    email: string,
    fullName: string,
    phoneNumber: string,
    password: string,
    address: AddressModel,
    dateOfBirth: Date,
    identityCardNumber: string,
    ssn: string
  ) {
    super(email, fullName, phoneNumber, password);
    this.address = address;
    this.dateOfBirth = dateOfBirth;
    this.identityCardNumber = identityCardNumber;
    this.ssn = ssn;
  }
}
