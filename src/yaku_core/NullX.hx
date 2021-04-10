package yaku_core;

import tink.CoreApi.Lazy;

class NullX {

    public static inline function orFallback<T>(n:Null<T>, fallback:Lazy<T>):T {
        return n != null ? n : fallback.get();
    }

    public static inline function nullThrows<T>(n:Null<T>):T {
        if (n == null){
            throw('unexpected null!');
        }
        return n;
    }
}