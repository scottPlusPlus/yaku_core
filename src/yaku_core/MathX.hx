package yaku_core;

class MathX {
	public static function map(val:Float, inFrom:Float, inTo:Float, outFrom:Float, outTo:Float):Float {
        return outFrom + (val - inFrom) * (outTo - outFrom) / (inTo - inFrom);
	}
}