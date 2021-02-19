import { Entity, PrimaryGeneratedColumn, ManyToOne } from "typeorm";
import UserEntity from "src/user/user.entity";
import { Serializable, JsonProperty } from "typescript-json-serializer";

@Entity()
@Serializable()
export default class AuthTokenEntity {
  @PrimaryGeneratedColumn("uuid")
  @JsonProperty()
  public id: string;

  @ManyToOne(() => UserEntity, (user) => user.authTokens)
  @JsonProperty()
  public user: UserEntity;

  constructor(user: UserEntity) {
    this.user = user;
  }
}
