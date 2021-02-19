import { IsString, IsOptional, IsBoolean } from "class-validator";

export default class GetAllQuery {
  @IsOptional()
  @IsString()
  public username?: string;

  @IsOptional()
  @IsString()
  public email?: string;

  @IsOptional()
  @IsBoolean()
  public verified?: boolean;

  @IsOptional()
  @IsString({ each: true })
  public roles?: string[];
}
