import { IDictionary } from "src/types";
import HandlerMetadata from "./handler.metadata";

export default class AclMetadata {
  public handlers: IDictionary<HandlerMetadata> = {};
}
