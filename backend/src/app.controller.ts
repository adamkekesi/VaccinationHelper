import { Controller, Get } from "@nestjs/common";
import { JsonProperty, Serializable } from "typescript-json-serializer";
import Response from "./shared/Response";

@Controller()
export class AppController {
  constructor() {}

  @Get("/")
  public async test() {
    return new Response({ data: new TestDto("asddsadsa") });
  }
}

@Serializable()
class TestDto {
  @JsonProperty()
  public name: string;

  constructor(name: string) {
    this.name = name;
  }
}
