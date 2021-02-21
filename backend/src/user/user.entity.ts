import AuthTokenEntity from "src/auth/entity/auth-token.entity";
import RoleModel from "src/role/models/role.model";
import RoleHelper from "src/role/role.helper";
import { roles } from "src/role/roles";
import { StoragePrefix } from "src/storage/decorator/storage-prefix.decorator";
import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  ManyToMany,
  JoinTable,
  OneToMany,
  TableInheritance,
  AfterLoad,
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

  @Column({ type: "simple-array" })
  public roleNames: string[];

  @OneToMany(() => AuthTokenEntity, (token) => token.user)
  public authTokens: Promise<AuthTokenEntity[]>;

  @JsonProperty()
  public type: "PatientEntity" | "DoctorEntity";

  @JsonProperty()
  public roles: RoleModel[];

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
      this.roleNames = [];
    }
  }

  public populateRoles() {
    this.roles = this.roleNames.map((name) => roles[name]);
  }

  @AfterLoad()
  private afterLoad() {
    this.populateRoles();
  }
}
