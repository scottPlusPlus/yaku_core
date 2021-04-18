package yaku_core_test;

import utest.Assert;

using yaku_core.FutureX;

class FutureXTest extends utest.Test {
	function testWait() {
		var f = FutureX.wait(100);
		Assert.notNull(f);
	}
}
