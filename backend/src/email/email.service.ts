import { Injectable } from "@nestjs/common";
import { Transporter, createTransport } from "nodemailer";
import { emailConfig } from "./config";
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
}
