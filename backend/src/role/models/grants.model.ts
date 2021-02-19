import { JsonProperty, Serializable } from "typescript-json-serializer";
import Resource from "./resource.model";

@Serializable()
export default class Grants {
  @JsonProperty()
  public resources: Resource[];

  constructor(resources: Resource[]) {
    this.resources = resources;
  }
}
