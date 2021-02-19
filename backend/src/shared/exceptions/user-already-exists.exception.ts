import { BadRequestException } from "@nestjs/common";

export default class UserAlreadyExists extends BadRequestException {}
