import { BadRequestException } from "@nestjs/common";

export default class InvalidToken extends BadRequestException {}
