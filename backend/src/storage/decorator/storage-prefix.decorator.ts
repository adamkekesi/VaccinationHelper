import EntityMetadata from "src/shared/decorators/metadata/entity.metadata";
import { Constructable } from "src/types";

export function StoragePrefix(prefix: string) {
  return (target: Constructable<any>) => {
    var meta: EntityMetadata = Reflect.getMetadata("entity", target);
    if (!meta) {
      meta = new EntityMetadata();
      Reflect.defineMetadata("entity", meta, target);
    }
    meta.storagePrefix = prefix;
  };
}
