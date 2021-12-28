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

    public function testIsSameStrings(){
        var a1 = ["a", "b", "c"];

        Assert.isTrue(a1.isSame(["a", "b", "c"]));
        Assert.isFalse(a1.isSame(["a", "b"]));
        Assert.isFalse(a1.isSame(["a", "b", "x"]));
        Assert.isFalse(a1.isSame(null));

        var sameStrings = function(s1:String, s2:String):Bool {
            return s1.length == s2.length;
        }
        Assert.isTrue(a1.isSame(["x", "y", "z"], sameStrings));
    }

    public function testIsSameInts(){
        var a1 = [1,2,3];
        Assert.isTrue(a1.isSame([1,2,3]));
        Assert.isFalse(a1.isSame([1,2,99]));
        Assert.isFalse(a1.isSame([1]));
    }
}