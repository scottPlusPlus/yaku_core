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

	// https://stackoverflow.com/questions/23689001/how-to-reliably-format-a-floating-point-number-to-a-specified-number-of-decimal
	public static function toStringPrecision(x:Float, precision:UInt):String {
		if (x == 0){
			return "0." + ([for (i in 0...precision) "0"].join("")); // quick return
		}

		var negative:Bool = (x < 0.0);
		x = Math.abs(x);
		var intPart:Int = Math.floor(x);
		var p = Math.pow(10, precision);
		var fracPart = Math.round(p * (x - intPart));
		var buf:StringBuf = new StringBuf();

		if (negative) {
			buf.addChar("-".code);
		}
			
		buf.add(Std.string(intPart));
		buf.addChar(".".code);
		if (fracPart == 0) {
			for (_ in 0...precision)
				buf.addChar("0".code);
		} else {
			p = p / 10;
			while (fracPart < p) {
				p = p / 10;
				buf.addChar("0".code);
			}
			buf.add(fracPart);
		}
		return buf.toString();
	}

	public static function truncate(x:Float, precision:UInt):Float {
		var str = toStringPrecision(x, precision);
		return Std.parseFloat(str);
	}
}
