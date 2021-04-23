package yaku_core;

import tink.CoreApi;

class NullX {

    public static inline function orFallback<T>(n:Null<T>, fallback:Lazy<T>):T {
        return n != null ? n : fallback.get();
    }

    public static inline function toOutcome<T>(n:Null<T>, ?err:Lazy<Error>, ?pos :haxe.PosInfos):Outcome<T,Error> {
        if (n != null){
            return Success(nullThrows(n));
        }
        if (err == null){
            err = new Error('unexpected null', pos);
        }
        return Failure(err.get());
    }

    public static inline function nullThrows<T>(n:Null<T>, msg:String = 'unexpected null'):T {
        if (n == null){
            throw(msg);
        }
        return n;
    }
}