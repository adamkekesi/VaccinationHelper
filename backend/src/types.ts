export type Constructable<T> = new (...any: any[]) => T;
export interface IDictionary<T> {
  [key: string]: T;
}

export interface Field {
  errorCodes: string[];
  children?: IDictionary<Field>;
}

export interface IPayloadException {
  serializeForSend(): any;
}
