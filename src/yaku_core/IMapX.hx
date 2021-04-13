package yaku_core;

import tink.CoreApi.Lazy;
import haxe.Constraints.IMap;

class IMapX {
    public static function copyTo<K,V>(from:IMap<K,V>, to:IMap<K,V>) {
        for (kv in from.keyValueIterator()){
            to.set(kv.key, kv.value);
        }
    }

    public static function getOrSet<K,V>(m:IMap<K,V>, key:K, fallback:Lazy<V>) : V {
        var val = m.get(key);
        if (val == null){
            val = fallback.get();
            m.set(key, val);
        }
        return val;
    }
}