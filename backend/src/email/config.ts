import {} from "nodemailer";
import SMTPTransport from "nodemailer/lib/smtp-transport";

export const emailConfig = {
  transport: {
    auth: {
      user: process.env.EMAIL_ADDRESS,
      pass: process.env.EMAIL_PASSWORD
    },
    service: "Yahoo"
  } as SMTPTransport.Options,
  url: process.env.URL || "http://localhost:3000",
  email: process.env.EMAIL_ADDRESS
};
