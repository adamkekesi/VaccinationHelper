import AuthTokenEntity from "src/auth/entity/auth-token.entity";
import TokenEntity from "src/auth/entity/token.entity";
import RoleEntity from "src/role/role.entity";
import { StoragePrefix } from "src/storage/decorator/storage-prefix.decorator";
import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  ManyToMany,
  JoinTable,
  OneToMany,
  TableInheritance,
} from "typeorm";
import { Serializable, JsonProperty } from "typescript-json-serializer";

@Entity()
@Serializable()
@TableInheritance({ column: { type: "varchar", name: "userType" } })
@StoragePrefix("user")
export default class UserEntity {
  @PrimaryGeneratedColumn("uuid")
  @JsonProperty()
  public id: string;

  @Column()
  @JsonProperty()
  public email: string;

  @Column()
  @JsonProperty()
  public fullName: string;

  @Column()
  @JsonProperty()
  public phoneNumber: string;

  @Column()
  @JsonProperty({
    beforeSerialize() {
      return undefined;
    },
  })
  public password: string;

  @ManyToMany(() => RoleEntity)
  @JoinTable()
  @JsonProperty()
  public roles: RoleEntity[];

  @OneToMany(() => AuthTokenEntity, (token) => token.user)
  public authTokens: Promise<AuthTokenEntity[]>;

  @OneToMany(() => TokenEntity, (token) => token.user)
  public tokens: Promise<TokenEntity[]>;

  @JsonProperty()
  public type: "PatientEntity" | "DoctorEntity";

  constructor(
    email: string,
    fullName: string,
    phoneNumber: string,
    password: string
  ) {
    if (email && password) {
      this.email = email;
      this.fullName = fullName;
      this.phoneNumber = phoneNumber;
      this.password = password;
      this.roles = [];
    }
  }
}
