package yaku_core_test;

import haxe.macro.Expr;
import yaku_core.test_utils.ExampleClass;
import zenlog.Log;
import utest.Assert;
import yaku_core.CommonSorters;

class CommonSortersTest extends utest.Test {
	public function testStrings() {
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

	public function testInts() {
		var initial = [2, 1, 3];

		var actual = initial.copy();
		actual.sort(CommonSorters.intsAscending);
		var expected = [1, 2, 3];
		Assert.same(expected, actual);

		actual = initial.copy();
		actual.sort(CommonSorters.intsDescending);
		var expected = [3, 2, 1];
		Assert.same(expected, actual);
	}

	public function testNullInts() {
		var initial = [2, null, 1, null, 3];

		var actual = initial.copy();
		actual.sort(CommonSorters.nullsAtStart(CommonSorters.intsAscending));
		var expected = [null, null, 1, 2, 3];
		Assert.same(expected, actual);

		actual = initial.copy();
		actual.sort(CommonSorters.nullsAtEnd(CommonSorters.intsAscending));
		expected = [1, 2, 3, null, null];
		Assert.same(expected, actual);
	}

	public function testMapAndSort() {
		var ex1 = new ExampleClass("ex1");
		var ex2 = new ExampleClass("ex2");
		var ex3 = new ExampleClass("ex3");
		var initial = [ex2, ex3, ex1];

		var actual = initial.copy();
		actual.sort(CommonSorters.mapAndSort(function(ex:ExampleClass) {
			return ex.string;
		}, CommonSorters.stringsAscending));
		var expected = [ex1, ex2, ex3];
		Assert.same(expected, actual);
	}
}
