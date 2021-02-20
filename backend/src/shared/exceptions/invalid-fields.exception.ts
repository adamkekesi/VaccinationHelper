import { BadRequestException } from "@nestjs/common";
import { ValidationError } from "class-validator";
import { IDictionary, Field, IPayloadException } from "src/types";
import { fromPairs } from "lodash";

export default class InvalidFields
  extends BadRequestException
  implements IPayloadException {
  public static fromOneInvalidField(name: string, errorCodes: string[]) {
    const err = new InvalidFields([]);
    err.fields[name] = { errorCodes: errorCodes };
    return err;
  }

  public static fromInvalidFields(fields: IDictionary<Field>) {
    const err = new InvalidFields([]);
    err.fields = fields;
    return err;
  }

  public fields: IDictionary<Field> = {};

  constructor(errors: ValidationError[]) {
    super();

    errors.forEach((e) => {
      this.fields[e.property] = {
        errorCodes: this.getErrorCodes(e),
        children: this.getChildren(e),
      };
    }, this);
  }

  public serializeForSend() {
    return { fields: this.fields };
  }

  private getChildren(error: ValidationError): IDictionary<Field> {
    if (error.children.length === 0) {
      return undefined;
    }
    return fromPairs(
      error.children.map((e) => {
        return [
          e.property,
          {
            errorCodes: this.getErrorCodes(e),
            children: this.getChildren(e),
          } as Field,
        ];
      }, this)
    );
  }

  private getErrorCodes(error: ValidationError) {
    var skipOthersConstraint = undefined;
    Object.keys(error?.contexts || {}).forEach((key) => {
      if (error.contexts[key]?.skipOthers) {
        skipOthersConstraint = key;
      }
    });
    if (skipOthersConstraint && error?.constraints[skipOthersConstraint]) {
      return [error.constraints[skipOthersConstraint]];
    }
    return Object.values(error.constraints);
  }
}
