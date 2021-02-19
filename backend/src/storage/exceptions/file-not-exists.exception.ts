import { BadRequestException, NotFoundException } from "@nestjs/common";

export default class FileNotExists extends NotFoundException {
  constructor() {
    super();
  }
}
