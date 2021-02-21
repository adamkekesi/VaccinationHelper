import DoctorEntity from "src/doctor/doctor.entity";
import PatientEntity from "src/patient/patient.entity";
import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { JsonProperty, Serializable } from "typescript-json-serializer";

@Serializable()
@Entity()
export default class VaccinationEntity {
  @JsonProperty()
  @PrimaryGeneratedColumn("uuid")
  public id: string;

  @JsonProperty()
  @ManyToOne(() => PatientEntity, (patient) => patient.vaccinationsInProgress)
  public patient: PatientEntity;

  @JsonProperty()
  @ManyToOne(() => DoctorEntity, (doctor) => doctor.coordinatedVaccinations)
  public vaccinator: DoctorEntity;

  @JsonProperty()
  @Column()
  public scheduledDate: Date;

  @JsonProperty()
  @Column("simple-array")
  public offeredAppointments: Date[];
}
