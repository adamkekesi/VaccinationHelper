import { JsonProperty, Serializable } from "typescript-json-serializer";

@Serializable()
export default class Operation {
  @JsonProperty()
  public name: string;

  @JsonProperty()
  public every: boolean;

  constructor(name: string, every = false) {
    this.name = name;
    this.every = every;
  }
}
