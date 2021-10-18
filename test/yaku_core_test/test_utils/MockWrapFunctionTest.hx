package yaku_core_test.test_utils;

import yaku_core.test_utils.MockWrapFunction;
import yaku_core.test_utils.TestVals;
import utest.Assert;

class MockWrapFunctionTest extends utest.Test {
	private function printInt(i:Int):String {
		return Std.string(i);
	}

	private function justFoo(i:Int):String {
		return TestVals.foo;
	}

	public function testMocks() {
		var expectedHistory = [];

		var mock = new MockWrapFunction(printInt);
		Assert.equals("1", mock.call(1));
		expectedHistory.push({input: 1, output: "1"});

		mock.overrideNext(justFoo);
		Assert.equals(TestVals.foo, mock.call(1));
		Assert.equals("1", mock.call(1));
		expectedHistory.push({input: 1, output: TestVals.foo});
		expectedHistory.push({input: 1, output: "1"});

		mock.implementation = justFoo;
		Assert.equals(TestVals.foo, mock.call(1));
		Assert.equals(TestVals.foo, mock.call(2));
		expectedHistory.push({input: 1, output: TestVals.foo});
		expectedHistory.push({input: 2, output: TestVals.foo});

		Assert.same(expectedHistory, mock.history);
	}

	public function testOverrideVal() {
		var mock = new MockWrapFunction(printInt);
		mock.overrideNext(TestVals.bar);
		Assert.equals(TestVals.bar, mock.call(123));
	}

	public function testWithVoid() {
		var sum = 0;
		var testFunc = function(i:Int):Void {
			sum += i;
		}

		var mock = new MockWrapFunction(testFunc);
		mock.call(2);
		Assert.equals(2, sum);
	}
}
