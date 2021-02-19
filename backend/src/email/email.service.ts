import { Injectable } from "@nestjs/common";
import { Transporter, createTransport } from "nodemailer";
import { emailConfig } from "./config";
import UserEntity from "src/user/user.entity";
import TokenEntity from "src/auth/entity/token.entity";
import nodemailerHbs from "./nodemailer-hbs";
import { resolve } from "path";

@Injectable()
export class EmailService {
  public transporter: Transporter;

  public async initMailer() {
    this.transporter = createTransport(emailConfig.transport);
    this.transporter.use(
      "compile",
      nodemailerHbs({
        viewPath: resolve(__dirname, "templates"),
      })
    );
  }

  public async sendPasswordReset(user: UserEntity, token: TokenEntity) {
    try {
      await this.transporter.sendMail({
        from: emailConfig.email,
        to: user.email,
        subject: "Jelszóvisszaállítás",
        template: "password-reset",
        context: { username: user.username, token: token.id },
      } as any);
    } catch (e) {
      console.log(e);
    }
  }

  public async sendEmailVerification(user: UserEntity, token: TokenEntity) {
    try {
      await this.transporter.sendMail({
        from: emailConfig.email,
        to: user.email,
        subject: "Email cím megerősítése",
        template: "email-verification",
        context: { username: user.username, token: token.id },
      } as any);
    } catch (e) {
      console.log(e);
    }
  }
}
