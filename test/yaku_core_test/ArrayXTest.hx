package yaku_core_test;

import zenlog.Log;
import utest.Assert;
import yaku_core.ArrayX;

using yaku_core.ArrayX;

class ArrayXTest extends utest.Test {
    
    public function testGoodIndex(){
        var array = ["a", "b", "c"];

        var actual = ArrayX.getOrNull(array, 2);
        Assert.same("c", actual);
    }

    public function testBadIndex(){
        var array = ["a", "b", "c"];

        var actual = ArrayX.getOrNull(array, 3);
        Assert.same(null, actual);
    }
}