import PatientEntity from "src/patient/patient.entity";
import UserEntity from "src/user/user.entity";
import VaccinationEntity from "src/vaccination/vaccination.entity";
import { ChildEntity, Column, Entity, ManyToOne, OneToMany } from "typeorm";
import { JsonProperty, Serializable } from "typescript-json-serializer";
import DoctorPatientConnectionEntity from "./doctor-patient-connection.entity";

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

  @JsonProperty()
  @OneToMany(() => DoctorPatientConnectionEntity, (conn) => conn.doctor, {
    eager: true,
  })
  public doctorPatientConnections: DoctorPatientConnectionEntity[];

  @JsonProperty()
  @OneToMany(() => VaccinationEntity, (vaccination) => vaccination.vaccinator)
  public coordinatedVaccinations: VaccinationEntity[];

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
