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

}
