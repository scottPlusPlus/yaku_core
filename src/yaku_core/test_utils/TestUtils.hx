package yaku_core.test_utils;

import haxe.Timer;
import zenlog.Log;

class TestUtils {

    public static function measure(f:Void->Void, loops:UInt):Float {
        var start = Date.now().getTime();
        var s2 = Timer.stamp();
        for (_ in 0...loops){
            f();
        }
        var end = Date.now().getTime();
        var e2 = Timer.stamp();
        Log.debug('start:$start -> end:$end = ${end - start}');
        Log.debug('s2:$s2 -> e2:$e2 = ${e2 - s2}');
        return end - start;
    }
}