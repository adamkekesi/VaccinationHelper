import { BadRequestException } from "@nestjs/common";

export default class AlreadyRequestedVaccination extends BadRequestException {}
