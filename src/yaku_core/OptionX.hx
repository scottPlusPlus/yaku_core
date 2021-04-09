package yaku_core;

import tink.core.Option;

class OptionX {
	public static function sure<T>(o:Option<T>):T {
		switch (o) {
			case Some(v):
				return v;
			case None:
				throw('expected option to be Some');
		}
	}
}
