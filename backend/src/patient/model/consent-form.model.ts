import {
  AfterLoad,
  BeforeInsert,
  Column,
  PrimaryGeneratedColumn,
} from "typeorm";
import {
  deserialize,
  JsonProperty,
  Serializable,
  serialize,
} from "typescript-json-serializer";
import AnswerModel from "./answer.model";

@Serializable()
export default class ConsentFormModel {
  @JsonProperty()
  public answers: AnswerModel[];

  @Column("simple-array")
  public answersJson: string[];

  constructor(answers: AnswerModel[]) {
    this.answers = answers || [];
  }

  @BeforeInsert()
  private beforeInsert() {
    this.answersJson = this.answers.map((a) => serialize(a));
  }

  @AfterLoad()
  private afterLoaded() {
    this.answers = (this.answersJson || []).map((j) =>
      deserialize(j, AnswerModel)
    );
  }
}
