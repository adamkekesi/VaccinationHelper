import { ForbiddenException } from "@nestjs/common";

export default class PermissionDenied extends ForbiddenException {}
