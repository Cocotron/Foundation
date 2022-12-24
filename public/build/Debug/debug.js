
var __$objj_bundle = {"resources":{},"styles":{}}

{var the_class = objj_allocateClassPair(Nil, "CTObject"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("isa", "id")]);objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("init"), function $CTObject__init(self, _cmd)
{
    return self;
}

,["id"]), new objj_method(sel_getUid("copy"), function $CTObject__copy(self, _cmd)
{
    return self;
}

,["id"]), new objj_method(sel_getUid("mutableCopy"), function $CTObject__mutableCopy(self, _cmd)
{
    return (self.isa.method_msgSend["copy"] || _objj_forward)(self, (self.isa.method_dtable["copy"], "copy"));
}

,["id"]), new objj_method(sel_getUid("class"), function $CTObject__class(self, _cmd)
{
    return self.isa;
}

,["Class"]), new objj_method(sel_getUid("isKindOfClass:"), function $CTObject__isKindOfClass_(self, _cmd, aClass)
{
    return ((___r1 = self.isa), ___r1 == null ? ___r1 : (___r1.isa.method_msgSend["isSubclassOfClass:"] || _objj_forward)(___r1, (self.isa.isa.method_dtable["isSubclassOfClass:"], "isSubclassOfClass:"), aClass));
    var ___r1;
}

,["BOOL","Class"]), new objj_method(sel_getUid("isMemberOfClass:"), function $CTObject__isMemberOfClass_(self, _cmd, aClass)
{
    return self.isa === aClass;
}

,["BOOL","Class"]), new objj_method(sel_getUid("isProxy"), function $CTObject__isProxy(self, _cmd)
{
    return NO;
}

,["BOOL"]), new objj_method(sel_getUid("respondsToSelector:"), function $CTObject__respondsToSelector_(self, _cmd, aSelector)
{
    return !!class_getInstanceMethod(self.isa, aSelector);
}

,["BOOL","SEL"]), new objj_method(sel_getUid("implementsSelector:"), function $CTObject__implementsSelector_(self, _cmd, aSelector)
{
    return ((___r1 = (self.isa.method_msgSend["class"] || _objj_forward)(self, (self.isa.method_dtable["class"], "class"))), ___r1 == null ? ___r1 : (___r1.isa.method_msgSend["instancesImplementSelector:"] || _objj_forward)(___r1, "instancesImplementSelector:", aSelector));
    var ___r1;
}

,["BOOL","SEL"]), new objj_method(sel_getUid("conformsToProtocol:"), function $CTObject__conformsToProtocol_(self, _cmd, aProtocol)
{
    return class_conformsToProtocol(self.isa, aProtocol);
}

,["BOOL","Protocol"]), new objj_method(sel_getUid("methodForSelector:"), function $CTObject__methodForSelector_(self, _cmd, aSelector)
{
    return class_getMethodImplementation(self.isa, aSelector);
}

,["IMP","SEL"]), new objj_method(sel_getUid("methodSignatureForSelector:"), function $CTObject__methodSignatureForSelector_(self, _cmd, aSelector)
{
    return nil;
}

,["CPMethodSignature","SEL"]), new objj_method(sel_getUid("description"), function $CTObject__description(self, _cmd)
{
    return "<" + class_getName(self.isa) + " 0x" + (CPString == null ? CPString : (CPString.isa.method_msgSend["stringWithHash:"] || _objj_forward)(CPString, (CPString.isa.method_dtable["stringWithHash:"], "stringWithHash:"), (self.isa.method_msgSend["UID"] || _objj_forward)(self, (self.isa.method_dtable["UID"], "UID")))) + ">";
}

,["CPString"]), new objj_method(sel_getUid("performSelector:"), function $CTObject__performSelector_(self, _cmd, aSelector)
{
    return self.isa.objj_msgSend0(self, aSelector);
}

,["id","SEL"]), new objj_method(sel_getUid("performSelector:withObject:"), function $CTObject__performSelector_withObject_(self, _cmd, aSelector, anObject)
{
    return self.isa.objj_msgSend1(self, aSelector, anObject);
}

,["id","SEL","id"]), new objj_method(sel_getUid("performSelector:withObject:withObject:"), function $CTObject__performSelector_withObject_withObject_(self, _cmd, aSelector, anObject, anotherObject)
{
    return self.isa.objj_msgSend2(self, aSelector, anObject, anotherObject);
}

,["id","SEL","id","id"]), new objj_method(sel_getUid("performSelector:withObjects:"), function $CTObject__performSelector_withObjects_(self, _cmd, aSelector, anObject)
{
    var params = [self, aSelector].concat(Array.prototype.slice.apply(arguments, [3]));
    return objj_msgSend.apply(this, params);
}

,["id","SEL","id"]), new objj_method(sel_getUid("forwardingTargetForSelector:"), function $CTObject__forwardingTargetForSelector_(self, _cmd, aSelector)
{
    return nil;
}

,["id","SEL"]), new objj_method(sel_getUid("doesNotRecognizeSelector:"), function $CTObject__doesNotRecognizeSelector_(self, _cmd, aSelector)
{
    throw new Error(class_isMetaClass(self.isa) ? "+" : "-" + " [" + (self.isa.method_msgSend["className"] || _objj_forward)(self, (self.isa.method_dtable["className"], "className")) + " " + aSelector + "] unrecognized selector sent to " + "class " + class_getName(self.isa));
}

,["void","SEL"]), new objj_method(sel_getUid("awakeAfterUsingCoder:"), function $CTObject__awakeAfterUsingCoder_(self, _cmd, aCoder)
{
    return self;
}

,["id","CPCoder"]), new objj_method(sel_getUid("classForKeyedArchiver"), function $CTObject__classForKeyedArchiver(self, _cmd)
{
    return (self.isa.method_msgSend["classForCoder"] || _objj_forward)(self, (self.isa.method_dtable["classForCoder"], "classForCoder"));
}

,["Class"]), new objj_method(sel_getUid("classForCoder"), function $CTObject__classForCoder(self, _cmd)
{
    return (self.isa.method_msgSend["class"] || _objj_forward)(self, (self.isa.method_dtable["class"], "class"));
}

,["Class"]), new objj_method(sel_getUid("replacementObjectForArchiver:"), function $CTObject__replacementObjectForArchiver_(self, _cmd, anArchiver)
{
    return (self.isa.method_msgSend["replacementObjectForCoder:"] || _objj_forward)(self, (self.isa.method_dtable["replacementObjectForCoder:"], "replacementObjectForCoder:"), anArchiver);
}

,["id","CPArchiver"]), new objj_method(sel_getUid("replacementObjectForKeyedArchiver:"), function $CTObject__replacementObjectForKeyedArchiver_(self, _cmd, anArchiver)
{
    return (self.isa.method_msgSend["replacementObjectForCoder:"] || _objj_forward)(self, (self.isa.method_dtable["replacementObjectForCoder:"], "replacementObjectForCoder:"), anArchiver);
}

,["id","CPKeyedArchiver"]), new objj_method(sel_getUid("replacementObjectForCoder:"), function $CTObject__replacementObjectForCoder_(self, _cmd, aCoder)
{
    return self;
}

,["id","CPCoder"]), new objj_method(sel_getUid("className"), function $CTObject__className(self, _cmd)
{
    return self.isa.name;
}

,["CPString"]), new objj_method(sel_getUid("hash"), function $CTObject__hash(self, _cmd)
{
    return (self.isa.method_msgSend["UID"] || _objj_forward)(self, (self.isa.method_dtable["UID"], "UID"));
}

,["unsigned"]), new objj_method(sel_getUid("UID"), function $CTObject__UID(self, _cmd)
{
    if (typeof self._UID === "undefined")
    {
        self._UID = objj_generateObjectUID();
    }
    return self._UID + "";
}

,["CPString"]), new objj_method(sel_getUid("isEqual:"), function $CTObject__isEqual_(self, _cmd, anObject)
{
    return self === anObject || (self.isa.method_msgSend["UID"] || _objj_forward)(self, (self.isa.method_dtable["UID"], "UID")) === (anObject == null ? anObject : (anObject.isa.method_msgSend["UID"] || _objj_forward)(anObject, (anObject.isa.method_dtable["UID"], "UID")));
}

,["BOOL","id"]), new objj_method(sel_getUid("self"), function $CTObject__self(self, _cmd)
{
    return self;
}

,["id"]), new objj_method(sel_getUid("superclass"), function $CTObject__superclass(self, _cmd)
{
    return self.isa.super_class;
}

,["Class"])]);
class_addMethods(meta_class, [new objj_method(sel_getUid("load"), function $CTObject__load(self, _cmd)
{
}

,["void"]), new objj_method(sel_getUid("initialize"), function $CTObject__initialize(self, _cmd)
{
}

,["void"]), new objj_method(sel_getUid("new"), function $CTObject__new(self, _cmd)
{
    return ((___r1 = (self.isa.method_msgSend["alloc"] || _objj_forward)(self, (self.isa.method_dtable["alloc"], "alloc"))), ___r1 == null ? ___r1 : (___r1.isa.method_msgSend["init"] || _objj_forward)(___r1, "init"));
    var ___r1;
}

,["id"]), new objj_method(sel_getUid("alloc"), function $CTObject__alloc(self, _cmd)
{
    return class_createInstance(self);
}

,["id"]), new objj_method(sel_getUid("allocWithCoder:"), function $CTObject__allocWithCoder_(self, _cmd, aCoder)
{
    return (self.isa.method_msgSend["alloc"] || _objj_forward)(self, (self.isa.method_dtable["alloc"], "alloc"));
}

,["id","CPCoder"]), new objj_method(sel_getUid("class"), function $CTObject__class(self, _cmd)
{
    return self;
}

,["Class"]), new objj_method(sel_getUid("superclass"), function $CTObject__superclass(self, _cmd)
{
    return self.super_class;
}

,["Class"]), new objj_method(sel_getUid("isSubclassOfClass:"), function $CTObject__isSubclassOfClass_(self, _cmd, aClass)
{
    var theClass = self;
    for (; theClass; theClass = theClass.super_class)
        if (theClass === aClass)
            return YES;
    return NO;
}

,["BOOL","Class"]), new objj_method(sel_getUid("isKindOfClass:"), function $CTObject__isKindOfClass_(self, _cmd, aClass)
{
    return (self.isa.method_msgSend["isSubclassOfClass:"] || _objj_forward)(self, (self.isa.method_dtable["isSubclassOfClass:"], "isSubclassOfClass:"), aClass);
}

,["BOOL","Class"]), new objj_method(sel_getUid("isMemberOfClass:"), function $CTObject__isMemberOfClass_(self, _cmd, aClass)
{
    return self === aClass;
}

,["BOOL","Class"]), new objj_method(sel_getUid("instancesRespondToSelector:"), function $CTObject__instancesRespondToSelector_(self, _cmd, aSelector)
{
    return !!class_getInstanceMethod(self, aSelector);
}

,["BOOL","SEL"]), new objj_method(sel_getUid("instancesImplementSelector:"), function $CTObject__instancesImplementSelector_(self, _cmd, aSelector)
{
    var methods = class_copyMethodList(self),
        count = methods.length;
    while (count--)
        if (method_getName(methods[count]) === aSelector)
            return YES;
    return NO;
}

,["BOOL","SEL"]), new objj_method(sel_getUid("conformsToProtocol:"), function $CTObject__conformsToProtocol_(self, _cmd, aProtocol)
{
    return class_conformsToProtocol(self, aProtocol);
}

,["BOOL","Protocol"]), new objj_method(sel_getUid("instanceMethodForSelector:"), function $CTObject__instanceMethodForSelector_(self, _cmd, aSelector)
{
    return class_getMethodImplementation(self, aSelector);
}

,["IMP","SEL"]), new objj_method(sel_getUid("description"), function $CTObject__description(self, _cmd)
{
    return class_getName(self.isa);
}

,["CPString"]), new objj_method(sel_getUid("setVersion:"), function $CTObject__setVersion_(self, _cmd, aVersion)
{
    class_setVersion(self, aVersion);
}

,["void","int"]), new objj_method(sel_getUid("version"), function $CTObject__version(self, _cmd)
{
    return class_getVersion(self);
}

,["int"])]);
}
function CPDescriptionOfObject(anObject, maximumRecursionDepth)
{
    if (anObject === nil)
        return "nil";
    if (anObject === undefined)
        return "undefined";
    if (anObject === window)
        return "window";
    if (maximumRecursionDepth === 0)
        return "...";
    if (anObject.isa)
    {
        if ((anObject == null ? anObject : (anObject.isa.method_msgSend["isKindOfClass:"] || _objj_forward)(anObject, (anObject.isa.method_dtable["isKindOfClass:"], "isKindOfClass:"), CPString)))
            return '@"' + (anObject == null ? anObject : (anObject.isa.method_msgSend["description"] || _objj_forward)(anObject, (anObject.isa.method_dtable["description"], "description"))) + '"';
        if ((anObject == null ? anObject : (anObject.isa.method_msgSend["respondsToSelector:"] || _objj_forward)(anObject, (anObject.isa.method_dtable["respondsToSelector:"], "respondsToSelector:"), sel_getUid("_descriptionWithMaximumDepth:"))))
            return (anObject == null ? anObject : (anObject.isa.method_msgSend["_descriptionWithMaximumDepth:"] || _objj_forward)(anObject, (anObject.isa.method_dtable["_descriptionWithMaximumDepth:"], "_descriptionWithMaximumDepth:"), maximumRecursionDepth !== undefined ? maximumRecursionDepth - 1 : maximumRecursionDepth));
        return (anObject == null ? anObject : (anObject.isa.method_msgSend["description"] || _objj_forward)(anObject, (anObject.isa.method_dtable["description"], "description")));
    }
    if (typeof anObject !== "object")
        return String(anObject);
    var properties = [],
        desc;
    for (var property in anObject)
        if (anObject.hasOwnProperty(property))
            properties.push(property);
    properties.sort();
    if (properties.length === 2 && anObject.hasOwnProperty("width") && anObject.hasOwnProperty("height"))
        desc = (CPString == null ? CPString : (CPString.isa.method_msgSend["stringWithFormat:"] || _objj_forward)(CPString, (CPString.isa.method_dtable["stringWithFormat:"], "stringWithFormat:"), "CGSize: (%f, %f)", anObject.width, anObject.height));
    else if (properties.length === 2 && anObject.hasOwnProperty("x") && anObject.hasOwnProperty("y"))
        desc = (CPString == null ? CPString : (CPString.isa.method_msgSend["stringWithFormat:"] || _objj_forward)(CPString, (CPString.isa.method_dtable["stringWithFormat:"], "stringWithFormat:"), "CGPoint: (%f, %f)", anObject.x, anObject.y));
    else if (properties.length === 2 && anObject.hasOwnProperty("origin") && anObject.hasOwnProperty("size"))
        desc = (CPString == null ? CPString : (CPString.isa.method_msgSend["stringWithFormat:"] || _objj_forward)(CPString, (CPString.isa.method_dtable["stringWithFormat:"], "stringWithFormat:"), "CGRect: (%f, %f), (%f, %f)", anObject.origin.x, anObject.origin.y, anObject.size.width, anObject.size.height));
    else if (properties.length === 4 && anObject.hasOwnProperty("top") && anObject.hasOwnProperty("right") && anObject.hasOwnProperty("bottom") && anObject.hasOwnProperty("left"))
        desc = (CPString == null ? CPString : (CPString.isa.method_msgSend["stringWithFormat:"] || _objj_forward)(CPString, (CPString.isa.method_dtable["stringWithFormat:"], "stringWithFormat:"), "CGInset: { top:%f, right:%f, bottom:%f, left:%f }", anObject.top, anObject.right, anObject.bottom, anObject.left));
    else
    {
        desc = "{";
        for (var i = 0; i < properties.length; ++i)
        {
            if (i === 0)
                desc += "\n";
            var value = anObject[properties[i]],
                valueDescription = CPDescriptionOfObject(value, maximumRecursionDepth !== undefined ? maximumRecursionDepth - 1 : maximumRecursionDepth).split("\n").join("\n    ");
            desc += "b" + properties[i] + ": " + valueDescription;
            if (i < properties.length - 1)
                desc += ",\n";
            else
                desc += "\n";
        }
        desc += "}";
    }
    return desc;
}


{var the_class = objj_allocateClassPair(CTObject, "CTArray"),
meta_class = the_class.isa;objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("addObject:"), function $CTArray__addObject_(self, _cmd, anObject)
{
    self.push(anObject);
}

,["void","id"]), new objj_method(sel_getUid("removeObject:"), function $CTArray__removeObject_(self, _cmd, anObject)
{
    var anIndex;
    while ((anIndex = self.indexOf.call(self, anObject)) !== -1)
        self.splice.call(self, anIndex, 1);
}

,["void","id"]), new objj_method(sel_getUid("removeAt:"), function $CTArray__removeAt_(self, _cmd, anIndex)
{
    self.splice.call(self, anIndex, 1);
}

,["void","Integer"]), new objj_method(sel_getUid("insertObject:at:"), function $CTArray__insertObject_at_(self, _cmd, anObject, anIndex)
{
    self.splice.call(self, anIndex, 0, anObject);
}

,["void","id","Integer"]), new objj_method(sel_getUid("removeAllObjects"), function $CTArray__removeAllObjects(self, _cmd)
{
    self.splice.call(self, 0, self.length);
}

,["void"]), new objj_method(sel_getUid("count"), function $CTArray__count(self, _cmd)
{
    return self.length;
}

,["Integer"])]);
class_addMethods(meta_class, [new objj_method(sel_getUid("alloc"), function $CTArray__alloc(self, _cmd)
{
    return [];
}

,["id"]), new objj_method(sel_getUid("array"), function $CTArray__array(self, _cmd)
{
    return [];
}

,["id"]), new objj_method(sel_getUid("arrayWithObjects:"), function $CTArray__arrayWithObjects_(self, _cmd, anObject)
{
    var index = 2,
        count = arguments.length;
    for (; index < count; ++index)
        if (arguments[index] === nil)
            break;
    return Array.prototype.slice.call(arguments, 2, index);
}

,["id","id"])]);
}
Array.prototype.isa = CTArray;

let array = (CTArray == null ? CTArray : (CTArray.isa.method_msgSend["arrayWithObjects:"] || _objj_forward)(CTArray, (CTArray.isa.method_dtable["arrayWithObjects:"], "arrayWithObjects:"), "One", "Two", "Three"));
(array == null ? array : (array.isa.method_msgSend["addObject:"] || _objj_forward)(array, (array.isa.method_dtable["addObject:"], "addObject:"), "Hello2"));
(array == null ? array : (array.isa.method_msgSend["insertObject:at:"] || _objj_forward)(array, (array.isa.method_dtable["insertObject:at:"], array.isa.method_dtable["insertObject:at:"], "insertObject:at:"), "Dog", 2));
(array == null ? array : (array.isa.method_msgSend["addObject:"] || _objj_forward)(array, (array.isa.method_dtable["addObject:"], "addObject:"), nil));
console.log("CTArray:");
console.log(array);
(array == null ? array : (array.isa.method_msgSend["removeAt:"] || _objj_forward)(array, (array.isa.method_dtable["removeAt:"], "removeAt:"), 0));
console.log((array == null ? array : (array.isa.method_msgSend["count"] || _objj_forward)(array, (array.isa.method_dtable["count"], "count"))));


{var the_class = objj_allocateClassPair(CTObject, "CTDictionary"),
meta_class = the_class.isa;objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("allKeys"), function $CTDictionary__allKeys(self, _cmd)
{
    return Array.from(self.keys.call(self));
}

,["CTArray"]), new objj_method(sel_getUid("allObjects"), function $CTDictionary__allObjects(self, _cmd)
{
    return Array.from(self.values.call(self));
}

,["CTArray"]), new objj_method(sel_getUid("containsKey:"), function $CTDictionary__containsKey_(self, _cmd, aKey)
{
    return self.has.call(self, aKey);
}

,["BOOL","String"]), new objj_method(sel_getUid("objectForKey:"), function $CTDictionary__objectForKey_(self, _cmd, aKey)
{
    return self.get.call(self, aKey);
}

,["id","String"]), new objj_method(sel_getUid("setObject:forKey:"), function $CTDictionary__setObject_forKey_(self, _cmd, anObject, aKey)
{
    self.set.call(self, aKey, anObject);
}

,["void","id","String"]), new objj_method(sel_getUid("removeObjectForKey:"), function $CTDictionary__removeObjectForKey_(self, _cmd, aKey)
{
    self.delete.call(self, aKey);
}

,["void","String"]), new objj_method(sel_getUid("count"), function $CTDictionary__count(self, _cmd)
{
    return self.size.call(self);
}

,["Integer"])]);
class_addMethods(meta_class, [new objj_method(sel_getUid("alloc"), function $CTDictionary__alloc(self, _cmd)
{
    return new Map();
}

,["id"]), new objj_method(sel_getUid("dictionary"), function $CTDictionary__dictionary(self, _cmd)
{
    return new Map();
}

,["id"])]);
}
Map.prototype.isa = CTDictionary;

{
var the_class = objj_getClass("CTObject")
if(!the_class) throw new SyntaxError("*** Could not find definition for class \"CTObject\"");
var meta_class = the_class.isa;class_addMethods(the_class, [new objj_method(sel_getUid("valueForKey:"), function $null__valueForKey_(self, _cmd, aKey)
{
    if ((self.isa.method_msgSend["respondsToSelector:"] || _objj_forward)(self, (self.isa.method_dtable["respondsToSelector:"], "respondsToSelector:"), sel_getUid("aKey")))
    {
        return (self.isa.method_msgSend["performSelector:"] || _objj_forward)(self, (self.isa.method_dtable["performSelector:"], "performSelector:"), sel_getUid("aKey"));
    }
    if (self[aKey])
    {
        return self[aKey];
    }
    throw new Error(`${(self.isa.method_msgSend["class"] || _objj_forward)(self, (self.isa.method_dtable["class"], "class"))} does not respond to key ${aKey}`);
}

,["id","String"]), new objj_method(sel_getUid("valueForKeyPath:"), function $null__valueForKeyPath_(self, _cmd, aKeyPath)
{
    const firstDotIndex = aKeyPath.indexOf(".");
    if (firstDotIndex < 0)
        return (self.isa.method_msgSend["valueForKey:"] || _objj_forward)(self, (self.isa.method_dtable["valueForKey:"], "valueForKey:"), aKeyPath);
    const firstKeyComponent = aKeyPath.substring(0, firstDotIndex),
        remainingKeyPath = aKeyPath.substring(firstDotIndex + 1),
        value = (self.isa.method_msgSend["valueForKey:"] || _objj_forward)(self, (self.isa.method_dtable["valueForKey:"], "valueForKey:"), firstKeyComponent);
    return (value == null ? value : (value.isa.method_msgSend["valueForKeyPath:"] || _objj_forward)(value, (value.isa.method_dtable["valueForKeyPath:"], "valueForKeyPath:"), remainingKeyPath));
}

,["id","CPString"]), new objj_method(sel_getUid("setValue:forKey:"), function $null__setValue_forKey_(self, _cmd, aValue, aKey)
{
    var capitalizedKey = aKey.charAt(0).toUpperCase() + aKey.substr(1),
        _selector = sel_getUid("set" + capitalizedKey + ":");
    if ((self.isa.method_msgSend["respondsToSelector:"] || _objj_forward)(self, (self.isa.method_dtable["respondsToSelector:"], "respondsToSelector:"), _selector))
    {
        (self.isa.method_msgSend["performSelector:withObject:"] || _objj_forward)(self, (self.isa.method_dtable["performSelector:withObject:"], self.isa.method_dtable["performSelector:withObject:"], "performSelector:withObject:"), _selector, aValue);
        return;
    }
    self[aKey] = aValue;
}

,["void","id","String"]), new objj_method(sel_getUid("setValue:forKeyPath:"), function $null__setValue_forKeyPath_(self, _cmd, aValue, aKeyPath)
{
    if (!aKeyPath)
        aKeyPath = "self";
    const firstDotIndex = aKeyPath.indexOf(".");
    if (firstDotIndex < 0)
        return (self.isa.method_msgSend["setValue:forKey:"] || _objj_forward)(self, (self.isa.method_dtable["setValue:forKey:"], self.isa.method_dtable["setValue:forKey:"], "setValue:forKey:"), aValue, aKeyPath);
    const firstKeyComponent = aKeyPath.substring(0, firstDotIndex),
        remainingKeyPath = aKeyPath.substring(firstDotIndex + 1),
        value = (self.isa.method_msgSend["valueForKey:"] || _objj_forward)(self, (self.isa.method_dtable["valueForKey:"], "valueForKey:"), firstKeyComponent);
    return (value == null ? value : (value.isa.method_msgSend["setValue:forKeyPath:"] || _objj_forward)(value, (value.isa.method_dtable["setValue:forKeyPath:"], value.isa.method_dtable["setValue:forKeyPath:"], "setValue:forKeyPath:"), aValue, remainingKeyPath));
}

,["void","id","String"])]);
}
{
var the_class = objj_getClass("CTDictionary")
if(!the_class) throw new SyntaxError("*** Could not find definition for class \"CTDictionary\"");
var meta_class = the_class.isa;class_addMethods(the_class, [new objj_method(sel_getUid("valueForKey:"), function $null__valueForKey_(self, _cmd, aKey)
{
    return (self.isa.method_msgSend["objectForKey:"] || _objj_forward)(self, (self.isa.method_dtable["objectForKey:"], "objectForKey:"), aKey);
}

,["id","String"]), new objj_method(sel_getUid("setValue:forKey:"), function $null__setValue_forKey_(self, _cmd, aValue, aKey)
{
    if (aValue != nil)
        (self.isa.method_msgSend["setObject:forKey:"] || _objj_forward)(self, (self.isa.method_dtable["setObject:forKey:"], self.isa.method_dtable["setObject:forKey:"], "setObject:forKey:"), aValue, aKey);
    else
        (self.isa.method_msgSend["removeObjectForKey:"] || _objj_forward)(self, (self.isa.method_dtable["removeObjectForKey:"], "removeObjectForKey:"), aKey);
}

,["void","id","String"])]);
}


{var the_class = objj_allocateClassPair(CTObject, "Pet"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("name", "String")]);objj_registerClassPair(the_class);
}

{var the_class = objj_allocateClassPair(CTObject, "Person"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("age", "Integer"), new objj_ivar("pet", "Pet")]);objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("age"), function $Person__age(self, _cmd)
{
    return self.age;
}

,["Integer"]), new objj_method(sel_getUid("setAge:"), function $Person__setAge_(self, _cmd, newValue)
{
    self.age = newValue;
}

,["void","Integer"]), new objj_method(sel_getUid("pet"), function $Person__pet(self, _cmd)
{
    return self.pet;
}

,["Pet"]), new objj_method(sel_getUid("setPet:"), function $Person__setPet_(self, _cmd, newValue)
{
    self.pet = newValue;
}

,["void","Pet"]), new objj_method(sel_getUid("init"), function $Person__init(self, _cmd)
{
    self = (objj_getClass("Person").super_class.method_dtable["init"] || _objj_forward)(self, "init");
    self.pet = (Pet.isa.method_msgSend["new"] || _objj_forward)(Pet, (Pet.isa.method_dtable["new"], "new"));
    return self;
}

,["id"])]);
}
var p = (Person.isa.method_msgSend["new"] || _objj_forward)(Person, (Person.isa.method_dtable["new"], "new"));
p.pet.name = "Carter";
p.age = 20;
console.log((p == null ? p : (p.isa.method_msgSend["respondsToSelector:"] || _objj_forward)(p, (p.isa.method_dtable["respondsToSelector:"], "respondsToSelector:"), "age")));
alert((p == null ? p : (p.isa.method_msgSend["valueForKeyPath:"] || _objj_forward)(p, (p.isa.method_dtable["valueForKeyPath:"], "valueForKeyPath:"), "pet.name")));
(p == null ? p : (p.isa.method_msgSend["setValue:forKeyPath:"] || _objj_forward)(p, (p.isa.method_dtable["setValue:forKeyPath:"], p.isa.method_dtable["setValue:forKeyPath:"], "setValue:forKeyPath:"), "Oksana", "pet.name"));
alert(p.pet.name);


//# sourceMappingURL=debug.js.map