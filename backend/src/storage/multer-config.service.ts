import { Injectable } from "@nestjs/common";
import {
  MulterOptionsFactory,
  MulterModuleOptions
} from "@nestjs/platform-express";
import { join } from "path";
import { diskStorage } from "multer";
import { exists, mkdir } from "fs";
import { promisify } from "util";

const existsAsync = promisify(exists);
const mkdirAsync = promisify(mkdir);

@Injectable()
export default class MulterConfigService implements MulterOptionsFactory {
  createMulterOptions(): MulterModuleOptions {
    return {
      storage: diskStorage({
        async destination(req, file, cb) {
          var dest: string;
          try {
            const res = req.res;
            const timestamp: string =
              res?.locals.uploadTimestamp || Date.now().toString();
            if (res) {
              res.locals.uploadTimestamp = timestamp;
            }
            dest = join(__dirname, "temp", timestamp);
            if (!(await existsAsync(dest))) {
              await mkdirAsync(dest, { recursive: true });
            }
          } catch (e) {
            return cb(e, null);
          }
          cb(null, dest);
        }
      })
    };
  }
}
