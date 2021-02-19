import { BadRequestException } from "@nestjs/common";

export default class InvalidAuthToken extends BadRequestException {}
