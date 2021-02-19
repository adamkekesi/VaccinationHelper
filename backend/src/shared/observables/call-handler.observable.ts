import { Observable, Subscription } from "rxjs";
import { CallHandler } from "@nestjs/common";

export default class CallHandlerObservable<T = any> extends Observable<T> {
  private responseStream: Observable<T>;

  private cb: () => any;

  constructor(private callHandler: CallHandler) {
    super((sub) => {
      var subscription: Subscription;
      if (this.responseStream) {
        subscription = this.responseStream.subscribe(sub);
      }
      const self = this;
      this.cb = () => {
        subscription = self.responseStream.subscribe(sub);
      };
      return {
        unsubscribe() {
          if (subscription) {
            subscription.unsubscribe();
          }
          self.cb = () => {};
        },
      };
    });
  }

  public run() {
    this.responseStream = this.callHandler.handle();
    if (this.cb) {
      this.cb();
    }
    return this;
  }
}
