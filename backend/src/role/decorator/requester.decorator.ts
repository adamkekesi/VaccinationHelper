import AclMetadata from "./metadata/acl.metadata";
import HandlerMetadata from "./metadata/handler.metadata";

export function Requester() {
  return (target: any, propertyKey: string, index: number) => {
    var meta: AclMetadata = Reflect.getMetadata("acl", target);
    if (!meta) {
      meta = new AclMetadata();
      Reflect.defineMetadata("acl", meta, target);
    }
    var handlerMeta = meta.handlers[propertyKey];
    if (!handlerMeta) {
      handlerMeta = new HandlerMetadata();
      meta.handlers[propertyKey] = handlerMeta;
    }
    handlerMeta.paramMetas["user"] = index;
  };
}
