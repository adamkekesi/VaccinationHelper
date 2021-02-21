import ConsentFormModel from "src/patient/model/consent-form.model";
import DoctorPatientConnectionEntity from "src/doctor/doctor-patient-connection.entity";
import DoctorEntity from "src/doctor/doctor.entity";
import UserEntity from "src/user/user.entity";
import {
  ChildEntity,
  Column,
  Entity,
  ManyToOne,
  OneToMany,
  OneToOne,
} from "typeorm";
import { JsonProperty, Serializable } from "typescript-json-serializer";
import AddressModel from "./model/address.model";
import VaccinationEntity from "src/vaccination/vaccination.entity";

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

  @JsonProperty()
  @Column(() => ConsentFormModel)
  public consentForm: ConsentFormModel;

  @JsonProperty()
  @OneToOne(() => DoctorPatientConnectionEntity, (conn) => conn.patient)
  public doctorPatientConnection: DoctorPatientConnectionEntity;

  @JsonProperty()
  @OneToMany(() => VaccinationEntity, (vaccination) => vaccination.patient)
  public vaccinationsInProgress: VaccinationEntity[];

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
