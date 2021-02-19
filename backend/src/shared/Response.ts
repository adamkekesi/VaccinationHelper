import {
  Serializable,
  JsonProperty,
  serialize,
} from "typescript-json-serializer";

@Serializable()
export default class Response {
  @JsonProperty({
    beforeSerialize(data: any) {
      var serializer = (data: any) => {
        if (typeof data !== "object") {
          return data;
        }
        if (Array.isArray(data)) {
          return data.map((x) => serializer(x));
        }
        const meta = Reflect.getMetadata(
          "api:map:serializable",
          data.constructor
        );
        if (meta) {
          return serialize(data, true);
        }
        Object.keys(data).forEach((key) => {
          const val = serializer(data[key]);
          data[key] = val;
        });
        return data;
      };
      return serializer(data);
    },
  })
  public data?: any;

  @JsonProperty()
  public error?: any;

  constructor(payload: { data?: any; error?: any }) {
    this.data = payload.data;
    this.error = payload.error;
  }
}
