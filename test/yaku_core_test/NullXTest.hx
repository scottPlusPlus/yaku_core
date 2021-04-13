package yaku_core_test;

import tink.CoreApi.Error;
import utest.Assert;
import yaku_core.test_utils.TestVals;

using yaku_core.NullX;
using yaku_core.OutcomeX;

class NullXTest extends utest.Test {
	private function echo(?val:String):Null<String> {
		return val;
	}

	function testOrFallback() {
		Assert.equals(TestVals.foo, echo(TestVals.foo).orFallback(TestVals.bar));
		Assert.equals(TestVals.bar, echo().orFallback(TestVals.bar));
	}

	function testToOutcome() {
		var o = echo(TestVals.foo).toOutcome();
		Assert.equals(TestVals.foo, o.sure());

		o = echo().toOutcome();
		Assert.isTrue(o.isFailure());

		o = echo().toOutcome(new Error(TestVals.jibbaJabba));
		Assert.equals(TestVals.jibbaJabba, o.failure().message);
	}

	function testNullThrows() {
		Assert.equals(TestVals.foo, echo(TestVals.foo).nullThrows());
		Assert.raises(function() {
			echo().nullThrows();
		});
	}
}
