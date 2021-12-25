package yaku_core.test_utils;

import tink.CoreApi.SignalTrigger;
import tink.CoreApi.Signal;
import tink.core.Noise;
using yaku_core.NullX;
using  yaku_core.ArrayX;

class MockWrapFunction<IN,OUT> {

    public var implementation:Action<IN,OUT>;
    public var scheduledOverrides:Array<Null<Action<IN,OUT>>> = [];
    public var history:Array<InOut<IN,OUT>> = [];
    
    public var signal (get,never):Signal<MockWrapFunction<IN,OUT>>;
    public function get_signal():Signal<MockWrapFunction<IN,OUT>> {
        return signalTrigger.asSignal();
    }
    private var signalTrigger:SignalTrigger<MockWrapFunction<IN,OUT>>;

    public inline function index():Int {
        return history.length;
    }

    public function new(action:Action<IN,OUT>){
        signalTrigger = new SignalTrigger();
        implementation = action;
    }

    public function call(input:IN):OUT{
        signalTrigger.trigger(this);
        var act = scheduledOverrides.getOrFallback(index(), implementation);
        var out = act.call(input);
        history.push({input:input, output:out});
        return out;
    }
 
    /*
        Overrides the next call of the function with the provided action.
        If nextIndex is provided, will override that call instead
        (example: 0th and 1st next calls will use standard implementation, but the next one will use the provided override)
    */
    public function overrideNextCall(action:Action<IN,OUT>, nextIndex:UInt = 0){
        nextIndex += index();
        scheduledOverrides.resize(nextIndex);
        scheduledOverrides[nextIndex] = action;
    }
}


typedef InOut<IN,OUT> = {
    input:IN,
    output:OUT
}


abstract Action<X,Y>(X->Y) from X->Y to X->Y {
    
    public function new(f:X->Y){
        this = f;
    }

    @:from static public inline function fromFunc<X,Y>(f:X->Y):Action<X,Y>{
        return cast f;
    }

    @:from static public inline function fromFuncVoid<X>(f:X->Void):Action<X,Noise> {
        var wrappedF = function(x:X):Noise{
            f(x);
            return Noise;
        }
        return new Action<X,Noise>(wrappedF);
    }

    @:from static public inline function fromFuncVoidIn<Y>(f:Void->Y):Action<Any,Y> {
        var wrappedF = function(a:Any):Y {
            return f();
        }
        return new Action<Any,Y>(wrappedF);
    }
    
    @:from static public inline function fromVal<X,Y>(v:Y):Action<X,Y>{
        var f = function(x:X):Y{
            return v;
        }
        return new Action<X,Y>(f);
    }

    @:to public function to():X->Y {
        return this;
    }

    public function call(x:X):Y {
        return this(x);
    }
}