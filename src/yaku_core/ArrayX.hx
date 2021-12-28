package yaku_core;

import zenlog.Log;
import tink.CoreApi.Lazy;
using yaku_core.NullX;

class ArrayX {
    public static inline function getOrNull<T>(arr:Array<T>, index:UInt):Null<T> {
        if (index >= arr.length){
            return null;
        }
        return arr[index];
    }

    public static inline function getOrFallback<T>(arr:Array<T>, index:UInt, fallback:Lazy<T>):T {
        return getOrNull(arr, index).orFallback(fallback);
    }

    public static function isSame<T>(a1:Array<T>, a2:Array<T>, ?equality:T->T->Bool):Bool {
        if (a1 == null && a2 == null){
            return true;
        }
        if (a1 == null || a2 == null){
            return false;
        }
        if (a1.length != a2.length){
            return false;
        }
        if (equality == null){
            equality = function(t1, t2){
                return t1 == t2;
            };
        }
        for (index in 0...a1.length){
            if (!equality(a1[index], a2[index])){
                return false;
            }
        }
        return true;
    }
}

