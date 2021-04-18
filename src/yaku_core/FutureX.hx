package yaku_core;

import haxe.Timer;
import tink.core.Noise;
import tink.core.Future;
import tink.CoreApi.FutureTrigger;

class FutureX {
	public static function wait(ms:UInt):Future<Noise> {
		var trigger = new FutureTrigger<Noise>();
		Timer.delay(function() {
			trigger.trigger(Noise);
		}, ms);
		return trigger.asFuture();
    }

    public static function thenWait<T>(f:Future<T>, ms:UInt):Future<Noise> {
        var res = new FutureTrigger<Noise>();
		f.handle(function(_) {
            Timer.delay(function() {
                res.trigger(Noise);
            }, ms);    
        });
		return res.asFuture();
    }
    
    public static inline function resolvedFuture<T>(val:T):Future<T> {
         var trig = new FutureTrigger<T>();
         trig.trigger(val);
         return trig.asFuture();
    }
}
