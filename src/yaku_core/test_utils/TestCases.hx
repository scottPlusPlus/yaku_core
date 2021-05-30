package yaku_core.test_utils;

@:forward(iterator, keyValueIterator, map)
abstract TestCases<T1,T2>(Array<TestCase<T1,T2>>) {
    
    public function new(){
        this = [];
    }

    public function push(input:T1, expected:T2){
        return this.push({
            input:input,
            expected: expected
        });
    }
}

typedef TestCase<T1,T2> = {
    input:T1,
    expected:T2
}