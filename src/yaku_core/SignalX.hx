package yaku_core;

import tink.core.Signal;

class SignalX {
    public static inline function onNext<T>(signal:Signal<T>, func:T->Void):Void {
        signal.nextTime().map(func).eager();
    }
}