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
		} else if (i1 >i2) {
			return 1;
		} else {
			return 0;
		}
    }

    public static inline function intsDescending(i1:Int, i2:Int):Int {
        if (i1 < i2) {
			return 1;
		} else if (i1 >i2) {
			return -1;
		} else {
			return 0;
		}
    }
}

