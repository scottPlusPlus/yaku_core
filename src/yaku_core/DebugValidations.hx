package yaku_core;

class DebugValidations {

    /*
    * Returns an Array of field names from the object that are null (via reflection)
    */
    public static function nullFields(obj:Dynamic):Array<String> {
        if (!Reflect.isObject(obj)){
            return [];
        }
        
        var nullFields = new Array<String>();
        var allFields:Array<String>;

        var cls = Type.getClass(obj);
        if (cls != null){
            allFields = Type.getInstanceFields(cls);
        } else {
            allFields = Reflect.fields(obj);
        }

        for (ff in allFields){
            var val = Reflect.field(obj, ff);
            if (val == null){
                nullFields.push(ff);
            }
        }
        return nullFields;
    }
}