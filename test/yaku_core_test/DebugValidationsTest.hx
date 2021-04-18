package yaku_core_test;

import yaku_core.CommonSorters;
import yaku_core.DebugValidations;
import utest.Assert;

class DebugValidationsTest extends utest.Test {
	function testNullFieldsClass() {
		var obj = new DVTestClass();
		var nullFields = DebugValidations.nullFields(obj);
		nullFields.sort(CommonSorters.stringsAscending);
		Assert.same(["myInt", "myRef", "myString"], nullFields);

		obj.myInt = 5;
		obj.myString = "foobar";
		obj.myRef = obj;
		nullFields = DebugValidations.nullFields(obj);
		Assert.same([], nullFields);
	}

	function testNullFieldsTypedef() {
		var obj:DVTestTd = {
			myString: null,
			myInt: null,
			myRef: null
		}
		var nullFields = DebugValidations.nullFields(obj);
		nullFields.sort(CommonSorters.stringsAscending);
		Assert.same(["myInt", "myRef", "myString"], nullFields);

		obj.myInt = 5;
		obj.myString = "foobar";
		obj.myRef = new DVTestClass();
		nullFields = DebugValidations.nullFields(obj);
		Assert.same([], nullFields);
	}
}

typedef DVTestTd = {
	myString:String,
	myInt:Int,
	myRef:DVTestClass,
}

class DVTestClass {
	public var myString:String;
	public var myInt:Int;
	public var myRef:DVTestClass;

	public function new() {}
}
