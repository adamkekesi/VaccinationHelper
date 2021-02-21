import { BadRequestException } from "@nestjs/common";

export default class VaccinationNotExists extends BadRequestException {}
