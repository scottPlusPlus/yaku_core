package yaku_core_test.test_utils;

import zenlog.LogTester;
import yaku_core.test_utils.TestVals;
import zenlog.ILogger;
import yaku_core.test_utils.TestLogger;
import utest.Assert;

class TestLogTest extends utest.Test {
	public function testLogsDebugOnlyOnError() {
		var logTester = new LogTester();
		var testLogger = new TestLogger(logTester);

		testLogger.beginTest("One");
		testLogger.debug("should be supressed");
		testLogger.finishTest();

		Assert.equals(0, logTester.debugData.length);

		testLogger.beginTest("Two");
		testLogger.debug(TestVals.gibberish);
		testLogger.error("example err");
		testLogger.finishTest();

		Assert.equals(3, logTester.debugData.length); // debug + begin / end test
		Assert.stringContains(TestVals.gibberish, logTester.debugData[1].message);
		Assert.equals(1, logTester.errorData.length);
	}

	public function testLevelPrefixes() {
		var logTester = new LogTester();
		var testLogger = new TestLogger(logTester);

		testLogger.beginTest("One");
		testLogger.info(TestVals.foo);
		testLogger.warn(TestVals.foo);
		testLogger.error(TestVals.foo);
		testLogger.critical(TestVals.foo);
		testLogger.finishTest();

		Assert.stringContains("foo", logTester.infoData[0].message);
		Assert.stringContains("WARN: foo", logTester.warnData[0].message);
		Assert.stringContains("ERROR: foo", logTester.errorData[0].message);
		Assert.stringContains("CRITICAL: foo", logTester.criticalData[0].message);
	}

	public function testIndention() {
		var logTester = new LogTester();
		var testLogger = new TestLogger(logTester);

		testLogger.beginTest("test");
		testLogger.info(TestVals.foo);
		proxyLogInfo(TestVals.bar, testLogger);
		testLogger.info(TestVals.foo2);
		testLogger.finishTest();

		Assert.same(". . foo", logTester.infoData[0].message);
		Assert.same(". . . . bar", logTester.infoData[1].message);
		Assert.same(". . foo2", logTester.infoData[2].message);
	}

	private function proxyLogInfo(msg:String, logger:ILogger) {
		logger.info(msg);
	}
}
