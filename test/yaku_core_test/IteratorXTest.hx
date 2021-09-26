package yaku_core_test;

import yaku_core.CommonSorters;
import yaku_core.IteratorX;
import utest.Assert;

class IteratorXTest extends utest.Test {

	function test_array() {
        var expected = [1,4,5,7,8,0];
        var iterator = expected.iterator();
        var actual = IteratorX.collect(iterator);
        Assert.same(expected, actual);
	}

    function test_map(){
        var m = new Map<String,String>();
        m.set("foo", "bar");
        m.set("voo","var");

        var actual = IteratorX.collect(m.iterator());
        actual.sort(CommonSorters.stringsAscending);
        Assert.same(["bar","var"], actual);
    }
}
