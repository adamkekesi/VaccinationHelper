import AclMetadata from "./metadata/acl.metadata";
import HandlerMetadata from "./metadata/handler.metadata";

export function RequiredPermissions(
  ...permissions: Array<{ resource: string; operation: string }>
) {
  return (target: any, propertyKey: string, descriptor: PropertyDescriptor) => {
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
    handlerMeta.requiredPermissions.push(permissions);
  };
}
