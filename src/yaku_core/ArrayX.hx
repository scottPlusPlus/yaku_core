package yaku_core;

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
}