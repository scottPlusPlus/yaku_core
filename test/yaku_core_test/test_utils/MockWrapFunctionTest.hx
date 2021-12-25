package yaku_core_test.test_utils;

import yaku_core.test_utils.SignalTester;
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

	private function historyToOutputs(io:InOut<Int,String>):String {
		return io.output;
	}

	public function testMocks() {
		var expectedHistory = [];

		var mock = new MockWrapFunction(printInt);
		Assert.equals("1", mock.call(1));
		expectedHistory.push({input: 1, output: "1"});

		mock.overrideNextCall(justFoo);
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
		mock.overrideNextCall(TestVals.bar);
		Assert.equals(TestVals.bar, mock.call(123));
	}

	public function testMultipleOverrides() {
		var mock = new MockWrapFunction(printInt);
		mock.overrideNextCall(TestVals.bar, 1);
		mock.overrideNextCall(TestVals.bar2, 2);
		mock.call(0);
		mock.call(1);
		mock.call(2);
		mock.call(3);
		var expectedHistory = ["0", TestVals.bar, TestVals.bar2, "3"];
		var actual = mock.history.map(historyToOutputs);
		Assert.same(expectedHistory, actual);
	}

	public function testSignal() {
		var mock = new MockWrapFunction(printInt);
		var signalTester = new SignalTester(mock.signal);
		mock.call(0);
		mock.call(1);
		Assert.equals(2, signalTester.input.length);
	}

	public function testVoidOut() {
		var sum = 0;
		var testFunc = function(i:Int):Void {
			sum += i;
		}

		var mock = new MockWrapFunction(testFunc);
		mock.call(2);
		Assert.equals(2, sum);
	}

	public function testVoidIn() {
		var testFunc = function():Int {
			return 5;
		}
		var mock = new MockWrapFunction(testFunc);
		var val = mock.call(null);
		Assert.equals(5, val);
	}

}
