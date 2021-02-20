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
import Grants from "./grants.model";
import Resource from "./resource.model";

@Serializable()
export default class RoleModel {
  @JsonProperty()
  public name: string;

  @JsonProperty()
  public grants: Resource[];

  constructor(name: string, grants: Resource[]) {
    this.name = name;
    this.grants = grants;
  }
}
