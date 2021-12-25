package yaku_core.test_utils;

import tink.core.Noise;
using yaku_core.NullX;

class MockWrapFunction<IN,OUT> {

    public var history:Array<InOut<IN,OUT>> = [];
    public var implementation:Action<IN,OUT>;
    public var next:Null<Action<IN,OUT>>;

    public function call(input:IN):OUT{
        var act = next.orFallback(implementation);
        next = null;
        var out = act.call(input);
        history.push({input:input, output:out});
        return out;
    }
 
    public function overrideNext(action:Action<IN,OUT>){
        next = action;
    }

    public function new(action:Action<IN,OUT>){
        implementation = action;
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