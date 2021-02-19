import { HttpException, HttpStatus } from "@nestjs/common";
import { IPayloadException } from "src/types";

export default class TooManyRequests
  extends HttpException
  implements IPayloadException {
  public retryAfter: number;

  constructor(retryAfter: number) {
    super("", HttpStatus.TOO_MANY_REQUESTS);
    this.retryAfter = retryAfter;
  }

  public serializeForSend() {
    return { retryAfter: this.retryAfter };
  }
}
