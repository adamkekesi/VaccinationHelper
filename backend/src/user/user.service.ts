import { Injectable } from "@nestjs/common";
import { DatabaseService } from "src/database/database.service";
import BaseService from "src/shared/base.service";

@Injectable()
export class UserService extends BaseService {
  constructor(private dbService: DatabaseService) {
    super();
  }
}
