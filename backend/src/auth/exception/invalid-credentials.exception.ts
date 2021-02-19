import { BadRequestException } from "@nestjs/common";

export default class InvalidCredentials extends BadRequestException {}
