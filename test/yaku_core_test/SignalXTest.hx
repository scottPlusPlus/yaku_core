package yaku_core_test;

import tink.core.Noise;
import utest.Assert;
import tink.core.Signal;

using yaku_core.SignalX;

class SignalXTest extends utest.Test {
	public function testOnNext(async:utest.Async) {
		var sig = new SignalTrigger<Noise>();
		sig.asSignal().onNext(function(_) {
			Assert.pass();
            async.done();
		});
		sig.trigger(Noise);
	}
}
