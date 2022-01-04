package yaku_core;

import tink.core.Promise;
import tink.CoreApi.PromiseTrigger;
import zenlog.Log;
import tink.CoreApi.Outcome;
import tink.core.Error;

using yaku_core.ErrorX;

class OutcomeX {
	public static inline function failure<D, F>(outcome:Outcome<D, F>):Null<F>
		return switch (outcome) {
			case Success(_):
				return null;
			case Failure(failure):
				return failure;
		}

	public static inline function isFailure<D, F>(outcome:Outcome<D, F>):Bool
		return switch (outcome) {
			case Success(_):
				return false;
			case Failure(_):
				return true;
		}

	public static inline function onFailure<D, F>(outcome:Outcome<D, F>, handler:F->Void):Void {
		switch (outcome) {
			case Success(_):
			case Failure(failure):
				handler(failure);
		}
	}

	/*
		if outcome is error, wraps that error
	 */
	public static inline function wrapErr<D>(outcome:Outcome<D, Error>, ?code:ErrorCode = InternalError, message:String, ?pos:Pos):Outcome<D, Error> {
		return switch (outcome) {
			case Success(s):
				return Success(s);
			case Failure(err):
				err = ErrorX.wrap(err, code, message, pos);
				return Failure(err);
		}
	}

	/*
		If outcome is error, logs it.  Returns the input.
	*/
	public static function logErr<D>(outcome:Outcome<D, Error>):Outcome<D,Error> {
		switch (outcome) {
			case Success(_):
			case Failure(failure):
				Log.error(failure.message, null, failure.pos);
		}
		return outcome;
	}


	public static inline function adapt<In,Out>(outcome:Outcome<In,Error>, adapter:In->Out):Outcome<Out,Error> {
		return switch (outcome) {
			case Success(x):
				var res = adapter(x);
				return Success(res);
			case Failure(err):
				return Failure(err);
		}
	}

	public static inline function asPromise<T>(outcome:Outcome<T,Error>):Promise<T> {
		var pt = new PromiseTrigger<T>();
		switch (outcome){
			case Success(data):
				pt.resolve(data);
			case Failure(failure):
				pt.reject(failure);
		}
		return pt.asPromise();
	}
}
