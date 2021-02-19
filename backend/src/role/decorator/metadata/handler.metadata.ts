import { IDictionary } from "src/types";

export default class HandlerMetadata {
  public requiredPermissions: Array<
    Array<{ resource: string; operation: string }>
  > = [];

  public paramMetas: IDictionary<number> = {};
}
