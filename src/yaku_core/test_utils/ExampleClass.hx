package yaku_core.test_utils;

class ExampleClass {
    public var string:String;
    public var int:Int;
    public var child:ExampleClass;

    public function new(?str:String, ?int:Int, ?child:ExampleClass){
        this.string = str;
        this.int = int;
        this.child = child;
    }
}