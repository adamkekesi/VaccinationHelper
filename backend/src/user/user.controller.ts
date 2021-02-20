import {
  Controller,
  Get,
  Param,
  NotImplementedException,
} from "@nestjs/common";
import { UserService } from "./user.service";
import { Protected } from "src/auth/decorator/protected.decorator";
import AuthenticatedUser from "src/auth/authenticated-user.model";
import { User } from "src/auth/decorator/authenticated-user.decorator";
import { Authenticate } from "src/auth/decorator/authenticate.decorator";

@Controller("user")
@Authenticate()
export class UserController {
  constructor(private userService: UserService) {}
}
