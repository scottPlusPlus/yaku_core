package yaku_core;

class IteratorX {

    public static function collect<T>(iterator:Iterator<T>):Array<T> {
        var array = new Array<T>();
        for (item in iterator){
            array.push(item);
        }
        return array;
    }
}