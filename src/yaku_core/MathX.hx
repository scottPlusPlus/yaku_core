package yaku_core;

class MathX {
	public static function map(val:Float, inFrom:Float, inTo:Float, outFrom:Float, outTo:Float):Float {
		return outFrom + (val - inFrom) * (outTo - outFrom) / (inTo - inFrom);
	}

	public static function clamp(value:Float, min:Float, max:Float):Float {
		if (value < min)
			return min;
		else if (value > max)
			return max;
		else
			return value;
	}
}
