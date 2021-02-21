import { JsonProperty, Serializable } from "typescript-json-serializer";
import { Serializer } from "v8";

@Serializable()
export default class AnswerModel {
  @JsonProperty()
  public questionId: string;

  @JsonProperty()
  public answer: boolean;

  constructor(questionId: string, answer: boolean) {
    this.questionId = questionId;
    this.answer = answer;
  }
}
