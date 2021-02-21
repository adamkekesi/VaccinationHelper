import PatientEntity from "src/patient/patient.entity";
import {
  Column,
  Entity,
  JoinTable,
  ManyToOne,
  OneToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { JsonProperty, Serializable } from "typescript-json-serializer";
import DoctorEntity from "./doctor.entity";

@Entity()
@Serializable()
export default class DoctorPatientConnectionEntity {
  @PrimaryGeneratedColumn("uuid")
  @JsonProperty()
  public id: string;

  @JsonProperty()
  @OneToOne(() => PatientEntity, (patient) => patient.doctorPatientConnection)
  @JoinTable()
  public patient: PatientEntity;

  @JsonProperty()
  @ManyToOne(() => DoctorEntity, (doctor) => doctor.doctorPatientConnections)
  public doctor: DoctorEntity;

  @JsonProperty()
  @Column()
  public isAccepted: boolean;

  constructor(patient: PatientEntity, doctor: DoctorEntity) {
    this.patient = patient;
    this.doctor = doctor;
  }
}
