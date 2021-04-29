package yaku_core.test_utils;

import tink.core.Signal;

class SignalTester<T> {
	public var input:Array<T> = new Array<T>();

	public function new(s:Signal<T>) {
		s.handle(this.activate);
	}

	private function activate(x:T) {
		input.push(x);
	}
}
