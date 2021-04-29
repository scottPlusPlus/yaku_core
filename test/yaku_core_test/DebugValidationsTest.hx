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
		obj.myRef = new Array<String>();

		nullFields = DebugValidations.nullFields(obj);
		Assert.same([], nullFields);
	}

	function testDeep() {
		var grandChild = new DVTestClass();
		grandChild.myString = "grandchild";
		grandChild.myInt = 0;
		grandChild.myRef = null;
		var child = new DVTestClass();
		child.myString = "child";
		child.myInt = 0;
		child.myRef = grandChild;
		var parent = new DVTestClass();
		parent.myString = "parent";
		parent.myInt = 0;
		parent.myRef = child;

		var nullFields = DebugValidations.nullFields(parent);
		nullFields.sort(CommonSorters.stringsAscending);
		Assert.same(["myRef.myRef.myRef"], nullFields);
	}

	function testRecursive() {
		var objA = new DVTestClass();
		objA.myString = "objA";
		var objB = new DVTestClass();
		objB.myString = "objB";
		var objC = new DVTestClass();
		objC.myString = "objC";

		objA.myRef = objB;
		objB.myRef = objC;
		objC.myRef = objA;

		var nullFields = DebugValidations.nullFields(objA);
		Assert.same(["myInt", "myRef.myInt", "myRef.myRef.myInt"], nullFields);
	}
}

typedef DVTestTd = {
	myString:String,
	myInt:Int,
	myRef:Array<String>,
}

class DVTestClass {
	public var myString:String;
	public var myInt:Int;
	public var myRef:DVTestClass;

	public function new() {}
}
