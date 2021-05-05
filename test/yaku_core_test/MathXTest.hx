package yaku_core_test;

import yaku_core.MathX;
import utest.Assert;

class MathXTest extends utest.Test {
	var x = 0.0;

	function test_map() {
		x = MathX.map(50, 0, 100, 0, 1000);
		Assert.equals(500, x);

		x = MathX.map(10, 0, 100, 0, 1000);
		Assert.equals(100, x);

		x = MathX.map(500, 0, 1000, 0, 100);
		Assert.equals(50, x);
	}

    function test_clamp(){
        Assert.equals(10, MathX.clamp(12, 0, 10));
        Assert.equals(0, MathX.clamp(-5, 0, 10));
        Assert.equals(7, MathX.clamp(7, 0, 10));
    }

	function testTrucate() {
		var val = 1.2345678;
		var trunc = function(prec:UInt):Float {
			return MathX.truncate(val, prec);
		};
		Assert.equals(1, trunc(0));
		Assert.equals(1.23, trunc(2));
		Assert.equals(1.235, trunc(3));
        Assert.equals(1.234568, trunc(6));

		val = 1234;
		Assert.equals(1234, trunc(2));
		Assert.equals(1234, trunc(3));

		val = -1.2345678;
		Assert.equals(-1.23, trunc(2));
		Assert.equals(-1.235, trunc(3));
	}
}
