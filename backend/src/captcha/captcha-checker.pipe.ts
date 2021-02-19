import { ArgumentMetadata, Injectable, PipeTransform } from "@nestjs/common";
import CaptchaDto from "./captcha.dto";
import axios from "axios";
import { recaptchaConfig } from "./captcha.config";
import InvalidCaptcha from "./exception/invalid-captcha.exception";

@Injectable()
export class CaptchaCheckerPipe implements PipeTransform {
  public async transform(value: CaptchaDto, metadata: ArgumentMetadata) {
    return value;
    const captcha = value.captcha;
    const ip = value.ipAddress;
    const res = await axios.post<{ success: boolean }>(
      recaptchaConfig.url,
      null,
      {
        params: {
          secret: recaptchaConfig.secretKey,
          response: captcha,
          remoteip: ip,
        },
        validateStatus() {
          return true;
        },
      }
    );
    if (!res.data.success) {
      throw new InvalidCaptcha();
    }
    return value;
  }
}
