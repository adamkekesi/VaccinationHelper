import UserEntity from "src/user/user.entity";
import { ChildEntity, Column, Entity } from "typeorm";
import { JsonProperty, Serializable } from "typescript-json-serializer";

@ChildEntity()
@Serializable()
export default class DoctorEntity extends UserEntity {
  @JsonProperty()
  @Column()
  public city: string;

  @JsonProperty()
  @Column()
  public isHomeDoctor: boolean;

  @JsonProperty()
  @Column()
  public isVaccinatorDoctor: boolean;

  constructor(
    email: string,
    fullName: string,
    phoneNumber: string,
    password: string,
    city: string,
    isHomeDoctor: boolean,
    isVaccinatorDoctor: boolean
  ) {
    super(email, fullName, phoneNumber, password);
    this.city = city;
    this.isHomeDoctor = isHomeDoctor;
    this.isVaccinatorDoctor = isVaccinatorDoctor;
  }
}
