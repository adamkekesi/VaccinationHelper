import Handlebars from "handlebars";
import { join } from "path";
import { readFile } from "fs";
import { promisify } from "util";

const readFileAsync = promisify(readFile);

export default class TemplateGenerator {
  private viewPath: string;

  private extName: string;

  constructor(opts: any) {
    this.viewPath = opts.viewPath;
    this.extName = opts.extName || ".handlebars";
  }

  public async render(mail: any, cb: any) {
    if (mail.data.html) return cb();
    try {
      var templatePath = join(this.viewPath, mail.data.template + this.extName);

      const template = Handlebars.compile(
        (await readFileAsync(templatePath)).toString()
      );

      const body = template(mail.data.context);
      mail.data.html = body;
      cb();
    } catch (e) {
      return cb(e);
    }
  }
}
