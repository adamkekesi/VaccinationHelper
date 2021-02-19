import { BadRequestException } from "@nestjs/common";

export default class InvalidCaptcha extends BadRequestException {}
