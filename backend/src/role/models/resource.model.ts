import Operation from "./operation.model";
import { JsonProperty, Serializable } from "typescript-json-serializer";

@Serializable()
export default class Resource {
  @JsonProperty()
  public name: string;

  @JsonProperty()
  public operations: Operation[];

  constructor(name: string, operations: Operation[]) {
    if (name && operations) {
      this.name = name;
      this.operations = operations;
    }
  }
}
