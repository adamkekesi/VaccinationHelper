import {
  AfterLoad,
  BeforeInsert,
  BeforeUpdate,
  Column,
  Entity,
  PrimaryGeneratedColumn,
} from "typeorm";
import {
  deserialize,
  JsonProperty,
  Serializable,
  serialize,
} from "typescript-json-serializer";
import Grants from "./models/grants.model";
import Resource from "./models/resource.model";

@Entity()
@Serializable()
export default class RoleEntity {
  @PrimaryGeneratedColumn("uuid")
  @JsonProperty()
  public id: string;

  @Column()
  @JsonProperty()
  public name: string;

  @JsonProperty()
  public grants: Resource[];

  @Column()
  @JsonProperty()
  public grantsJson: string;

  constructor(name: string, grants: Resource[]) {
    if (name && grants) {
      this.name = name;
      this.grants = grants;
      this.grantsJson = "";
    }
  }

  @BeforeInsert()
  private beforeInsert() {
    this.prepareForSave();
  }

  @BeforeUpdate()
  private beforeUpdate() {
    this.prepareForSave();
  }

  @AfterLoad()
  private afterLoad() {
    var deserialized = deserialize(JSON.parse(this.grantsJson), Grants);
    console.log(deserialized);
    this.grants = deserialized?.resources || [];
  }

  private prepareForSave() {
    this.grantsJson = JSON.stringify(serialize(new Grants(this.grants)));
  }
}
