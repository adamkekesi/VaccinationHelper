import AuthTokenEntity from "src/auth/entity/auth-token.entity";
import TokenEntity from "src/auth/entity/token.entity";
import RoleEntity from "src/role/role.entity";
import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  ManyToMany,
  JoinTable,
  OneToMany,
} from "typeorm";
import { Serializable, JsonProperty } from "typescript-json-serializer";

@Entity()
@Serializable()
export default class UserEntity {
  @PrimaryGeneratedColumn("uuid")
  @JsonProperty()
  public id: string;

  @Column()
  @JsonProperty()
  public email: string;

  @Column()
  @JsonProperty()
  public username: string;

  @Column()
  @JsonProperty({
    beforeSerialize() {
      return undefined;
    },
  })
  public password: string;

  @Column()
  @JsonProperty()
  public verified: boolean;

  @ManyToMany(() => RoleEntity)
  @JoinTable()
  @JsonProperty()
  public roles: RoleEntity[];

  @OneToMany(() => AuthTokenEntity, (token) => token.user)
  public authTokens: Promise<AuthTokenEntity[]>;

  @OneToMany(() => TokenEntity, (token) => token.user)
  public tokens: Promise<TokenEntity[]>;

  constructor(email: string, username: string, password: string) {
    if (email && username && password) {
      this.email = email;
      this.username = username;
      this.password = password;
      this.verified = false;
      this.roles = [];
    }
  }
}
