import { BadRequestException } from "@nestjs/common";

export default class DoctorPatientConnectionNotExists extends BadRequestException {}
