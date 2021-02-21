import { IsBoolean, IsNotEmpty } from "class-validator";
import { JsonProperty, Serializable } from "typescript-json-serializer";

@Serializable()
export default class AnswerDto {
  @JsonProperty()
  @IsNotEmpty({ message: "questionId-empty" })
  public questionId: string;

  @JsonProperty()
  @IsBoolean({ message: "answer-invalid" })
  public answer: boolean;
}
