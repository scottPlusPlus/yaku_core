package yaku_core;

import zenlog.Log;

class DebugValidations {
	/*
	 * Returns an Array of field names from the object that are null (via reflection). Breadth-first.
	 */
	public static function nullFields(obj:Dynamic, ?checked:Array<Dynamic>):Array<String> {
		var res = new Array<String>();
		var children = new Array<Child>();

		children.push({
			path: "",
			obj: obj
		});

		var i = 0;
		while (i < children.length) {
			var child = children[i];
			var r = nullFieldsHelper(child.obj, child.path);

			for (n in r.nulls) {
				res.push(n);
			}
			for (newChild in r.children) {
				if (!isDuplicate(newChild, children)) {
					children.push(newChild);
				}
			}
			i++;
		}
		return res;
	}

	private static function isDuplicate(child:Child, existing:Array<Child>):Bool {
		for (c in existing) {
			if (c.obj == child.obj) {
				return true;
			}
		}
		return false;
	}

	private static function nullFieldsHelper(obj:Dynamic, path:String):NullsAndChildren {
		var res = {
			nulls: new Array<String>(),
			children: new Array<Dynamic>()
		};

		if (!Reflect.isObject(obj)) {
			res;
		}

		var allFields:Array<String>;

		var cls = Type.getClass(obj);
		if (cls != null) {
			allFields = Type.getInstanceFields(cls);
		} else {
			allFields = Reflect.fields(obj);
		}

		if (path.length > 0) {
			path += ".";
		}
		for (ff in allFields) {
			var val = Reflect.field(obj, ff);
			var resPath = path + ff;
			if (val == null) {
				res.nulls.push(resPath);
			} else {
				res.children.push({
					path: resPath,
					obj: val
				});
			}
		}
		return res;
	}
}

typedef NullsAndChildren = {
	nulls:Array<String>,
	children:Array<Child>
}

typedef Child = {
	path:String,
	obj:Dynamic
}
