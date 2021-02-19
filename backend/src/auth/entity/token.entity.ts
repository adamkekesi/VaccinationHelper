import { Entity, Column, PrimaryGeneratedColumn, ManyToOne } from "typeorm";
import { TokenType } from "src/types";
import UserEntity from "src/user/user.entity";
import { JsonProperty } from "typescript-json-serializer";

@Entity()
export default class TokenEntity {
  @PrimaryGeneratedColumn("uuid")
  @JsonProperty()
  public id: string;

  @ManyToOne(() => UserEntity)
  public user: UserEntity;

  @Column({ enum: TokenType })
  @JsonProperty()
  public type: TokenType;

  @Column()
  @JsonProperty()
  public expiresAt: Date;

  constructor(user: UserEntity, type: TokenType, expiresIn: Date) {
    if (user && type !== undefined && expiresIn) {
      this.user = user;
      this.type = type;
      const expireInMS =
        expiresIn.getTime() - new Date(0, 0, 0, 0, 0, 0, 0).getTime();
      const now = Date.now();
      this.expiresAt = new Date(now + expireInMS);
    }
  }

  public isValid(type?: TokenType) {
    if (new Date() > this.expiresAt) {
      return false;
    }

    if (type != null && this.type !== type) {
      return false;
    }
    return true;
  }
}
