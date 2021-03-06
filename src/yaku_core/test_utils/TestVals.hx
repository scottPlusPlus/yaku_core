package yaku_core.test_utils;

class TestVals {
    public static final foo = "foo";
    public static final bar = "bar";
    public static final foo2 = "foo2";
    public static final bar2 = "foo2";
    public static final foo3 = "foo3";
    public static final bar3 = "foo3";
    public static final gibberish = "gibberish";
    public static final jibbaJabba= "jibbaJabba";
    public static final exampleText = "exampleText";
    public static final key1 = "key1";
    public static final key2 = "key2";
    public static final key3 = "key3";
    public static final val1 = "val1";
    public static final val2 = "val2";
    public static final val3 = "val3";
    public static final keys_0to9 = ["key0", "key1", "key2", "key3", "key4", "key5", "key6", "key7", "key8", "key9"];
    public static final vals_0to9 = ["val0", "val1", "val2", "val3", "val4", "val5", "val6", "val7", "val8", "val9"];

    public static function mapWithKVP_0to9():Map<String,String> {
        var m = new Map<String,String>();
        for (i in 0...10){
            m.set(keys_0to9[i], vals_0to9[i]);
        }
        return m;
    }
}