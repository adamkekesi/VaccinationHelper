import {
  CallHandler,
  ExecutionContext,
  Injectable,
  NestInterceptor,
} from "@nestjs/common";
import { Request } from "express";
import IpAddressDto from "../dto/ip-address.dto.";

@Injectable()
export class IpAddressInterceptor implements NestInterceptor {
  public intercept(context: ExecutionContext, next: CallHandler) {
    const req: Request = context.switchToHttp().getRequest();
    if (typeof req.body !== "object" || !(req.body instanceof IpAddressDto)) {
      return next.handle();
    }
    req.body.ipAddress = req.socket.remoteAddress;
    return next.handle();
  }
}
