package yaku_core.test_utils;

import zenlog.Log;
import tink.CoreApi;
import utest.Assert;

using yaku_core.OutcomeX;
using yaku_core.PromiseX;

class PromiseTestUtils {
	public function new(){}

	public static inline function assertNoErr<T>(p:Promise<T>):Promise<T> {
		return p.mapError(function(err:Error){
			Log.error(err);
            Assert.isNull(err);
            return err;
		});
	}

	public static inline function assertErrAndContinue<T>(p:Promise<T>, onFail:String = "expected an error"):Promise<Noise> {
		return p.flatMap(function(o){
            switch o {
                case Failure(_):
                case Success(_):
                    Assert.fail(onFail);
            }
            return Noise;
		});
	}

	public static inline function closeTestChain<T>(p:Promise<T>, async:utest.Async, allowError = false){
		if (!allowError){
			p = PromiseTestUtils.assertNoErr(p);
		}

		return p.noise().recoverWith(Noise).next(function(v:Noise){
			async.done();
			return v;
		}).eager();
	}

	public static inline function logOutcome<T>(p:Promise<T>, str:String = ""):Promise<T>{
		return p.map(function(o:Outcome<T,Error>){
			if (o.isFailure()){
				Log.error('${str}${o.failure()}');
			} else {
				Log.info('${str}${o.sure()}');
			}
			return o;
		});
	}
}