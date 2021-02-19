import TemplateGenerator from "./generator";

export default function(options: { viewPath: string }) {
  var generator = new TemplateGenerator(options);

  return function(mail: any, cb: any) {
    generator.render(mail, cb);
  };
}
