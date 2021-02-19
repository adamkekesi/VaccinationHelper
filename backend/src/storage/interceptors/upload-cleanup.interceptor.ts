import {
  CallHandler,
  ExecutionContext,
  Injectable,
  NestInterceptor
} from "@nestjs/common";
import { Response } from "express";
import { join } from "path";
import { rmdir } from "fs";
import { promisify } from "util";
import { finalize } from "rxjs/operators";
const rimraf = require("rimraf");
const rimrafAsync = promisify(rimraf);

@Injectable()
export class UploadCleanupInterceptor implements NestInterceptor {
  public intercept(context: ExecutionContext, next: CallHandler) {
    return next.handle().pipe(
      finalize(async () => {
        try {
          const res: Response = context.switchToHttp().getResponse();
          const timestamp = res.locals.uploadTimestamp;
          if (timestamp) {
            const path = join(__dirname, "../temp", timestamp);
            await rimrafAsync(path);
          }
        } catch (e) {}
      })
    );
  }
}
