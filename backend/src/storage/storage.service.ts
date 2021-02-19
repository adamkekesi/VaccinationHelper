import { Injectable } from "@nestjs/common";
import { mkdir, copyFile, exists, createReadStream, readdir } from "fs";
import { promisify } from "util";
import { resolve, join } from "path";
import { forEach } from "p-iteration";
import { IDictionary } from "src/types";
import EntityMetadata from "src/shared/decorators/metadata/entity.metadata";
import { storageConfig } from "./storageConfig";
import { fork } from "child_process";
import Identifiable from "src/shared/Identifiable";
import FileNotExists from "./exceptions/file-not-exists.exception";

const rimraf = require("rimraf");
const sanitize = require("sanitize-filename");
const rimrafAsync = promisify(rimraf);
const mkdirAsync = promisify(mkdir);
const existsAsync = promisify(exists);
const copyFileAsync = promisify(copyFile);
const readdirAsync = promisify(readdir);

@Injectable()
export class StorageService {
  public async saveFiles(
    files: Express.Multer.File[],
    entity: Identifiable,
    path?: string
  ) {
    const dir = resolve(
      storageConfig.path,
      this.getPrefix(entity),
      entity.id,
      path || ""
    );
    await mkdirAsync(dir, {
      recursive: true,
    });

    await forEach(files, async (file) => {
      var filename = path ? file.originalname : file.fieldname;

      const location = join(dir, filename);
      await copyFileAsync(file.path, location);
    });
  }

  public async updateFiles(
    files: Express.Multer.File[],
    filesToDelete: string[],
    entity: Identifiable,
    path?: string
  ) {
    const dir = resolve(
      storageConfig.path,
      this.getPrefix(entity),
      entity.id,
      path || ""
    );

    if (!(await existsAsync(dir))) {
      await mkdirAsync(dir, {
        recursive: true,
      });
    }
    await forEach(filesToDelete, async (name) => {
      if (sanitize(name) !== name) {
        return;
      }
      await rimrafAsync(join(dir, name));
    });

    await forEach(files, async (file) => {
      var filename = path ? file.originalname : file.fieldname;

      const dest = join(dir, filename);
      if (await existsAsync(dest)) {
        await rimrafAsync(dest);
      }
      await copyFileAsync(file.path, dest);
    });
  }

  public async deleteFiles(id: string, prefix: string) {
    const dir = resolve(storageConfig.path, prefix, id);
    await rimrafAsync(dir);
  }

  public async getFile(entity: Identifiable, filename: string, path?: string) {
    const dir = resolve(
      storageConfig.path,
      this.getPrefix(entity),
      entity.id,
      path || ""
    );
    if (!(await existsAsync(dir))) {
      throw new FileNotExists();
    }
    return createReadStream(join(dir, filename));
  }

  public async getFileNames(
    entity: Identifiable,
    path?: string
  ): Promise<string[]> {
    const dir = resolve(
      storageConfig.path,
      this.getPrefix(entity),
      entity.id,
      path || ""
    );
    if (!(await existsAsync(dir))) {
      return [];
    }
    return await readdirAsync(dir);
  }

  private getPrefix(entity: any) {
    return (
      (Reflect.getMetadata(
        "entity",
        entity?.constructor || Function
      ) as EntityMetadata)?.storagePrefix || "others"
    );
  }
}
