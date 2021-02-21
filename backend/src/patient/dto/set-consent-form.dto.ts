import { IsInstance, isInstance, isNotEmpty } from "class-validator";
import { JsonProperty, Serializable } from "typescript-json-serializer";
import AnswerDto from "./answer.dto";

@Serializable()
export default class SetConsentFormDto {
  @JsonProperty({ type: AnswerDto })
  @IsInstance(AnswerDto, { each: true, message: "answers-invalid" })
  public answers: AnswerDto[];
}
