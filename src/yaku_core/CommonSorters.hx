package yaku_core;

class CommonSorters {
	public static inline function stringsAscending(s1:String, s2:String):Int {
		s1 = s1.toUpperCase();
		s2 = s2.toUpperCase();
		if (s1 < s2) {
			return -1;
		} else if (s1 > s2) {
			return 1;
		} else {
			return 0;
		}
	}

	public static inline function stringsDescending(s1:String, s2:String):Int {
		s1 = s1.toUpperCase();
		s2 = s2.toUpperCase();
		if (s1 < s2) {
			return 1;
		} else if (s1 > s2) {
			return -1;
		} else {
			return 0;
		}
	}

	public static inline function intsAscending(i1:Int, i2:Int):Int {
		if (i1 < i2) {
			return -1;
		} else if (i1 > i2) {
			return 1;
		} else {
			return 0;
		}
	}

	public static inline function intsDescending(i1:Int, i2:Int):Int {
		if (i1 < i2) {
			return 1;
		} else if (i1 > i2) {
			return -1;
		} else {
			return 0;
		}
	}

	public static inline function floatsAscending(f1:Float, f2:Float):Int {
		if (f1 < f2) {
			return -1;
		} else if (f1 > f2) {
			return 1;
		} else {
			return 0;
		}
	}

	public static inline function floatsDescending(f1:Float, f2:Float):Int {
		if (f1 < f2) {
			return 1;
		} else if (f1 > f2) {
			return -1;
		} else {
			return 0;
		}
	}

	public static inline function nullsAtStart<T>(sorter:T->T->Int):Null<T>->Null<T>->Int {
		return function(a:Null<T>, b:Null<T>) {
			if (a == null) {
				if (b == null) {
					return 0;
				}
				return -1;
			}
			if (b == null) {
				return 1;
			}
			return sorter(a, b);
		}
	}

	public static inline function nullsAtEnd<T>(sorter:T->T->Int):Null<T>->Null<T>->Int {
		return function(a:Null<T>, b:Null<T>) {
			if (a == null) {
				if (b == null) {
					return 0;
				}
				return 1;
			}
			if (b == null) {
				return -1;
			}
			return sorter(a, b);
		}
	}

	public static inline function mapAndSort<T,U>(adapter:T->U, sorter:U->U->Int):T->T->Int {
		return function (a:T, b:T):Int {
			var ax = adapter(a);
			var bx = adapter(b);
			return sorter(ax, bx);
		}
	}
}
