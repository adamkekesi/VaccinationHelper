import { SetMetadata } from "@nestjs/common";

export const Authenticate = () => SetMetadata("authenticate", true);
