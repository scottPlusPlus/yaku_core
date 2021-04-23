package yaku_core_test;

import utest.Assert;
import yaku_core.CommonSorters;

class CommonSortersTest extends utest.Test {
    
    public function testStrings(){
        var initial = ["b", "a", "c"];

        var actual = initial.copy();
        actual.sort(CommonSorters.stringsAscending);
        var expected = ["a", "b", "c"];
        Assert.same(expected, actual);

        actual = initial.copy();
        actual.sort(CommonSorters.stringsDescending);
        var expected = ["c", "b", "a"];
        Assert.same(expected, actual);
    }
}