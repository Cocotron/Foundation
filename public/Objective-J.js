// Objective-J Constants
NO = false;
YES = true;
nil = null;
Nil = null;
NULL = null;
ABS = Math.abs;
ASIN = Math.asin;
ACOS = Math.acos;
ATAN = Math.atan;
ATAN2 = Math.atan2;
SIN = Math.sin;
COS = Math.cos;
TAN = Math.tan;
EXP = Math.exp;
POW = Math.pow;
CEIL = Math.ceil;
FLOOR = Math.floor;
ROUND = Math.round;
MIN = Math.min;
MAX = Math.max;
RAND = Math.random;
SQRT = Math.sqrt;
E = Math.E;
LN2 = Math.LN2;
LN10 = Math.LN10;
LOG = Math.log;
LOG2E = Math.LOG2E;
LOG10E = Math.LOG10E;
PI = Math.PI;
PI2 = Math.PI * 2.0;
PI_2 = Math.PI / 2.0;
SQRT1_2 = Math.SQRT1_2;
SQRT2 = Math.SQRT2;
var CLS_CLASS = 0x1,
    CLS_META = 0x2,
    CLS_INITIALIZED = 0x4,
    CLS_INITIALIZING = 0x8;
// MAXIMUM_RECURSION_CHECKS
// If defined, objj_msgSend will check for recursion deeper than MAXIMUM_RECURSION_DEPTH and
// throw an error if found. While crude, this can be helpful when your JavaScript debugger
// crashes on recursion errors (e.g. Safari) or ignores them (e.g. Chrome).
// #define MAXIMUM_RECURSION_CHECKS
if(typeof global === "undefined") {
    global = window;
}
var OBJECT_COUNT = 0;
var objj_generateObjectUID = function()
{
    return OBJECT_COUNT++;
}
var objj_ivar = function(/*String*/ aName, /*String*/ aType)
{
    this.name = aName;
    this.type = aType;
}
var objj_method = function(/*String*/ aName, /*IMP*/ anImplementation, /*Array<String>*/ types)
{
    var method = anImplementation || function(/*id*/ aReceiver, /*SEL*/ aSelector) {
         throw new Error(aReceiver.isa.method_msgSend0(self, "className") + " does not have an implementation for selector '" + aSelector + "'");
    };
    method.method_name = aName;
    method.method_imp = anImplementation;
    method.method_types = types;
    return method;
}
var objj_class = function(displayName)
{
    this.isa = NULL;
    this.version = 0;
    this.super_class = NULL;
    this.name = NULL;
    this.info = 0;
    this.ivar_list = [];
    this.ivar_store = function() { };
    this.ivar_dtable = this.ivar_store.prototype;
    this.method_list = [];
    this.method_store = function() { };
    this.method_dtable = this.method_store.prototype;
    this.protocol_list = [];
    this.allocator = function() { };
    this._UID = -1;
}
var objj_protocol = function(/*String*/ aName)
{
    this.name = aName;
    this.instance_methods = { };
    this.class_methods = { };
}
var objj_object = function()
{
    this.isa = NULL;
    this._UID = -1;
}
var objj_typeDef = function(/*String*/ aName)
{
    this.name = aName;
}
// Working with Classes
var class_getName = function(/*Class*/ aClass)
{
    if (aClass == Nil)
        return "";
    return aClass.name;
}
var class_isMetaClass = function(/*Class*/ aClass)
{
    if (!aClass)
        return NO;
    return ((aClass.info & (CLS_META)));
}
var class_getSuperclass = function(/*Class*/ aClass)
{
    if (aClass == Nil)
        return Nil;
    return aClass.super_class;
}
var class_setSuperclass = function(/*Class*/ aClass, /*Class*/ aSuperClass)
{
    // Set up the actual class hierarchy.
    aClass.super_class = aSuperClass;
    aClass.isa.super_class = aSuperClass.isa;
}
var class_addIvar = function(/*Class*/ aClass, /*String*/ aName, /*String*/ aType)
{
    var thePrototype = aClass.allocator.prototype;
    // FIXME: Use getInstanceVariable
    if (typeof thePrototype[aName] != "undefined")
        return NO;
    var ivar = new objj_ivar(aName, aType);
    aClass.ivar_list.push(ivar);
    aClass.ivar_dtable[aName] = ivar;
    thePrototype[aName] = NULL;
    return YES;
}
var class_addIvars = function(/*Class*/ aClass, /*Array*/ivars)
{
    var index = 0,
        count = ivars.length,
        thePrototype = aClass.allocator.prototype;
    for (; index < count; ++index)
    {
        var ivar = ivars[index],
            name = ivar.name;
        // FIXME: Use getInstanceVariable
        if (typeof thePrototype[name] === "undefined")
        {
            aClass.ivar_list.push(ivar);
            aClass.ivar_dtable[name] = ivar;
            thePrototype[name] = NULL;
        }
    }
}
var class_copyIvarList = function(/*Class*/ aClass)
{
    return aClass.ivar_list.slice(0);
}
//#define class_copyIvarList(aClass) (aClass.ivar_list.slice(0))
var class_addMethod = function(/*Class*/ aClass, /*SEL*/ aName, /*IMP*/ anImplementation, /*Array<String>*/ types)
{
    // FIXME: return NO if it exists?
    var method = new objj_method(aName, anImplementation, types);
    aClass.method_list.push(method);
    aClass.method_dtable[aName] = method;
    // FIXME: Should this be done here?
    // If this is a root class...
    if (!((aClass.info & (CLS_META))) && (((aClass.info & (CLS_META))) ? aClass : aClass.isa).isa === (((aClass.info & (CLS_META))) ? aClass : aClass.isa))
        class_addMethod((((aClass.info & (CLS_META))) ? aClass : aClass.isa), aName, anImplementation, types);
    return YES;
}
var class_addMethods = function(/*Class*/ aClass, /*Array*/ methods)
{
    var index = 0,
        count = methods.length,
        method_list = aClass.method_list,
        method_dtable = aClass.method_dtable;
    for (; index < count; ++index)
    {
        var method = methods[index];
        // FIXME: Don't do it if it exists?
        method_list.push(method);
        method_dtable[method.method_name] = method;
    }
    // If this is a root class...
    if (!((aClass.info & (CLS_META))) && (((aClass.info & (CLS_META))) ? aClass : aClass.isa).isa === (((aClass.info & (CLS_META))) ? aClass : aClass.isa))
        class_addMethods((((aClass.info & (CLS_META))) ? aClass : aClass.isa), methods);
}
var class_getInstanceMethod = function(/*Class*/ aClass, /*SEL*/ aSelector)
{
    if (!aClass || !aSelector)
        return NULL;
    var method = aClass.method_dtable[aSelector];
    return method ? method : NULL;
}
var class_getInstanceVariable = function(/*Class*/ aClass, /*String*/ aName)
{
    if (!aClass || !aName)
        return NULL;
    // FIXME: this doesn't appropriately deal with Object's properties.
    var variable = aClass.ivar_dtable[aName];
    return variable;
}
var class_getClassMethod = function(/*Class*/ aClass, /*SEL*/ aSelector)
{
    if (!aClass || !aSelector)
        return NULL;
    var method = (((aClass.info & (CLS_META))) ? aClass : aClass.isa).method_dtable[aSelector];
    return method ? method : NULL;
}
var class_respondsToSelector = function(/*Class*/ aClass, /*SEL*/ aSelector)
{
    return class_getClassMethod(aClass, aSelector) != NULL;
}
var class_copyMethodList = function(/*Class*/ aClass)
{
    return aClass.method_list.slice(0);
}
var class_getVersion = function(/*Class*/ aClass)
{
    return aClass.version;
}
var class_setVersion = function(/*Class*/ aClass, /*Integer*/ aVersion)
{
    aClass.version = parseInt(aVersion, 10);
}
var class_replaceMethod = function(/*Class*/ aClass, /*SEL*/ aSelector, /*IMP*/ aMethodImplementation)
{
    if (!aClass || !aSelector)
        return NULL;
    var method = aClass.method_dtable[aSelector],
        method_imp = method.method_imp,
        new_method = new objj_method(method.method_name, aMethodImplementation, method.method_types);
    new_method.displayName = method.displayName;
    aClass.method_dtable[aSelector] = new_method;
    var index = aClass.method_list.indexOf(method);
    if (index !== -1)
    {
        aClass.method_list[index] = new_method;
    }
    else
    {
        aClass.method_list.push(new_method);
    }
    return method_imp;
}
var class_addProtocol = function(/*Class*/ aClass, /*Protocol*/ aProtocol)
{
    if (!aProtocol || class_conformsToProtocol(aClass, aProtocol))
    {
        return;
    }
    (aClass.protocol_list || (aClass.protocol_list = [])).push(aProtocol);
    return true;
}
var class_conformsToProtocol = function(/*Class*/ aClass, /*Protocol*/ aProtocol)
{
    if (!aProtocol)
        return false;
    while (aClass)
    {
        var protocols = aClass.protocol_list,
            size = protocols ? protocols.length : 0;
        for (var i = 0; i < size; i++)
        {
            var p = protocols[i];
            if (p.name === aProtocol.name)
            {
                return true;
            }
            if (protocol_conformsToProtocol(p, aProtocol))
            {
                return true;
            }
        }
        aClass = class_getSuperclass(aClass);
    }
    return false;
}
var class_copyProtocolList = function(/*Class*/ aClass)
{
    var protocols = aClass.protocol_list;
    return protocols ? protocols.slice(0) : [];
}
var protocol_conformsToProtocol = function(/*Protocol*/ p1, /*Protocol*/ p2)
{
    if (!p1 || !p2)
        return false;
    if (p1.name === p2.name)
        return true;
    var protocols = p1.protocol_list,
        size = protocols ? protocols.length : 0;
    for (var i = 0; i < size; i++)
    {
        var p = protocols[i];
        if (p.name === p2.name)
        {
            return true;
        }
        if (protocol_conformsToProtocol(p, p2))
        {
            return true;
        }
    }
   return false;
}
var REGISTERED_PROTOCOLS = Object.create(null);
var objj_allocateProtocol = function(/*String*/ aName)
{
    var protocol = new objj_protocol(aName);
    return protocol;
}
var objj_registerProtocol = function(/*Protocol*/ proto)
{
    REGISTERED_PROTOCOLS[proto.name] = proto;
}
var protocol_getName = function(/*Protocol*/ proto)
{
    return proto.name;
}
// Right now we only register required methods. THis might need to change in the future
var protocol_addMethodDescription = function(/*Protocol*/ proto, /*SEL*/ selector, /*Array*/ types, /*BOOL*/ isRequiredMethod, /*BOOL*/ isInstanceMethod)
{
    if (!proto || !selector) return;
    if (isRequiredMethod)
        (isInstanceMethod ? proto.instance_methods : proto.class_methods)[selector] = new objj_method(selector, null, types);
}
var protocol_addMethodDescriptions = function(/*Protocol*/ proto, /*Array*/ methods, /*BOOL*/ isRequiredMethod, /*BOOL*/ isInstanceMethod)
{
    if (!isRequiredMethod) return;
    var index = 0,
        count = methods.length,
        method_dtable = isInstanceMethod ? proto.instance_methods : proto.class_methods;
    for (; index < count; ++index)
    {
        var method = methods[index];
        method_dtable[method.method_name] = method;
    }
}
var protocol_copyMethodDescriptionList = function(/*Protocol*/ proto, /*BOOL*/ isRequiredMethod, /*BOOL*/ isInstanceMethod)
{
    if (!isRequiredMethod)
        return [];
    var method_dtable = isInstanceMethod ? proto.instance_methods : proto.class_methods,
        methodList = [];
    for (var selector in method_dtable)
        if (method_dtable.hasOwnProperty(selector))
            methodList.push(method_dtable[selector]);
    return methodList;
}
var protocol_addProtocol = function(/*Protocol*/ proto, /*Protocol*/ addition)
{
    if (!proto || !addition) return;
    (proto.protocol_list || (proto.protocol_list = [])).push(addition);
}
var REGISTERED_TYPEDEFS = Object.create(null);
var objj_allocateTypeDef = function(/*String*/ aName)
{
    var typeDef = new objj_typeDef(aName);
    return typeDef;
}
var objj_registerTypeDef = function(/*TypeDef*/ typeDef)
{
    REGISTERED_TYPEDEFS[typeDef.name] = typeDef;
}
var typeDef_getName = function(/*TypeDef*/ typeDef)
{
    return typeDef.name;
}
var _class_initialize = function(/*Class*/ aClass)
{
    var meta = (((aClass.info & (CLS_META))) ? aClass : aClass.isa);
    if ((aClass.info & (CLS_META)))
        aClass = objj_getClass(aClass.name);
    if (aClass.super_class && !((((aClass.super_class.info & (CLS_META))) ? aClass.super_class : aClass.super_class.isa).info & (CLS_INITIALIZED)))
        _class_initialize(aClass.super_class);
    if (!(meta.info & (CLS_INITIALIZED)) && !(meta.info & (CLS_INITIALIZING)))
    {
        meta.info = (meta.info | (CLS_INITIALIZING)) & ~(0);
        // We don't need to initialize any more.
        aClass.objj_msgSend = objj_msgSendFast;
        aClass.objj_msgSend0 = objj_msgSendFast0;
        aClass.objj_msgSend1 = objj_msgSendFast1;
        aClass.objj_msgSend2 = objj_msgSendFast2;
        aClass.objj_msgSend3 = objj_msgSendFast3;
        meta.objj_msgSend = objj_msgSendFast;
        meta.objj_msgSend0 = objj_msgSendFast0;
        meta.objj_msgSend1 = objj_msgSendFast1;
        meta.objj_msgSend2 = objj_msgSendFast2;
        meta.objj_msgSend3 = objj_msgSendFast3;
        aClass.method_msgSend = aClass.method_dtable;
        var metaMethodDTable = meta.method_msgSend = meta.method_dtable,
            initializeImp = metaMethodDTable["initialize"];
        if (initializeImp)
            initializeImp(aClass, "initialize");
        meta.info = (meta.info | (CLS_INITIALIZED)) & ~(CLS_INITIALIZING);
    }
}
var _objj_forward = function(self, _cmd)
{
    var isa = self.isa,
        meta = (((isa.info & (CLS_META))) ? isa : isa.isa);
    if (!(meta.info & (CLS_INITIALIZED)) && !(meta.info & (CLS_INITIALIZING)))
    {
        _class_initialize(isa);
    }
    var implementation = isa.method_msgSend[_cmd];
    if (implementation)
    {
        return implementation.apply(isa, arguments);
    }
    implementation = isa.method_dtable[SEL_forwardingTargetForSelector_];
    if (implementation)
    {
        var target = implementation(self, SEL_forwardingTargetForSelector_, _cmd);
        if (target && target !== self)
        {
            arguments[0] = target;
            return target.isa.objj_msgSend.apply(target.isa, arguments);
        }
    }
    implementation = isa.method_dtable[SEL_methodSignatureForSelector_];
    if (implementation)
    {
        var forwardInvocationImplementation = isa.method_dtable[SEL_forwardInvocation_];
        if (forwardInvocationImplementation)
        {
            var signature = implementation(self, SEL_methodSignatureForSelector_, _cmd);
            if (signature)
            {
                var invocationClass = objj_lookUpClass("CPInvocation");
                if (invocationClass)
                {
                    var invocation = invocationClass.isa.objj_msgSend1(invocationClass, SEL_invocationWithMethodSignature_, signature),
                        index = 0,
                        count = arguments.length;
                    if (invocation != null) {
                        var invocationIsa = invocation.isa;
                        for (; index < count; ++index)
                            invocationIsa.objj_msgSend2(invocation, SEL_setArgument_atIndex_, arguments[index], index);
                    }
                    forwardInvocationImplementation(self, SEL_forwardInvocation_, invocation);
                    return invocation == null ? null : invocationIsa.objj_msgSend0(invocation, SEL_returnValue);
                }
            }
        }
    }
    implementation = isa.method_dtable[SEL_doesNotRecognizeSelector_];
    if (implementation)
        return implementation(self, SEL_doesNotRecognizeSelector_, _cmd);
    throw class_getName(isa) + " does not implement doesNotRecognizeSelector: when sending " + sel_getName(_cmd) + ". Did you forget a superclass for " + class_getName(isa) + "?";
};
// I think this forward:: may need to be a common method, instead of defined in CPObject.
var class_getMethodImplementation = function(/*Class*/ aClass, /*SEL*/ aSelector)
{
    if (!((((aClass.info & (CLS_META))) ? aClass : aClass.isa).info & (CLS_INITIALIZED))) _class_initialize(aClass); var implementation = aClass.method_dtable[aSelector] || _objj_forward;;
    return implementation;
}
// Adding Classes
var REGISTERED_CLASSES = Object.create(null);
var objj_enumerateClassesUsingBlock = function(/* function(aClass) */aBlock)
{
    for (var key in REGISTERED_CLASSES)
    {
        aBlock(REGISTERED_CLASSES[key]);
    }
}
var objj_allocateClassPair = function(/*Class*/ superclass, /*String*/ aName)
{
    var classObject = new objj_class(aName),
        metaClassObject = new objj_class(aName),
        rootClassObject = classObject;
    // If we don't have a superclass, we are the root class.
    if (superclass)
    {
        rootClassObject = superclass;
        while (rootClassObject.superclass)
            rootClassObject = rootClassObject.superclass;
        // Give our current allocator all the instance variables of our super class' allocator.
        classObject.allocator.prototype = new superclass.allocator;
        // "Inherit" parent properties.
        classObject.ivar_dtable = classObject.ivar_store.prototype = new superclass.ivar_store;
        classObject.method_dtable = classObject.method_store.prototype = new superclass.method_store;
        metaClassObject.method_dtable = metaClassObject.method_store.prototype = new superclass.isa.method_store;
        // Set up the actual class hierarchy.
        classObject.super_class = superclass;
        metaClassObject.super_class = superclass.isa;
    }
    else
        classObject.allocator.prototype = new objj_object();
    classObject.isa = metaClassObject;
    classObject.name = aName;
    classObject.info = CLS_CLASS;
    classObject._UID = objj_generateObjectUID();
    // It needs initialize
    classObject.init = true;
    metaClassObject.isa = rootClassObject.isa;
    metaClassObject.name = aName;
    metaClassObject.info = CLS_META;
    metaClassObject._UID = objj_generateObjectUID();
    // It needs initialize
    metaClassObject.init = true;
    return classObject;
}
var CONTEXT_BUNDLE = nil;
var objj_registerClassPair = function(/*Class*/ aClass)
{
    global[aClass.name] = aClass;
    REGISTERED_CLASSES[aClass.name] = aClass;
}
var objj_resetRegisterClasses = function()
{
    for (var key in REGISTERED_CLASSES)
        delete global[key];
    REGISTERED_CLASSES = Object.create(null);
    REGISTERED_PROTOCOLS = Object.create(null);
    REGISTERED_TYPEDEFS = Object.create(null);
}
// Instantiating Classes
var class_createInstance = function(/*Class*/ aClass)
{
    if (!aClass)
        throw new Error("*** Attempting to create object with Nil class.");
    var object = new aClass.allocator();
    object.isa = aClass;
    object._UID = objj_generateObjectUID();
    return object;
}
// Opera 9.5.1 has a bug where prototypes "inheret" members from instances when "with" is used.
// Given that the Opera team is so fond of bug-testing instead of version-testing, we'll go
// ahead and do that.
var prototype_bug = function() { }
prototype_bug.prototype.member = false;
with (new prototype_bug())
    member = true;
// If the bug exists, go down the slow path.
if (new prototype_bug().member)
{
var fast_class_createInstance = class_createInstance;
class_createInstance = function(/*Class*/ aClass)
{
    var object = fast_class_createInstance(aClass);
    if (object)
    {
        var theClass = object.isa,
            actualClass = theClass;
        while (theClass)
        {
            var ivars = theClass.ivar_list,
                count = ivars.length;
            while (count--)
                object[ivars[count].name] = NULL;
            theClass = theClass.super_class;
        }
        object.isa = actualClass;
    }
    return object;
}
}
// Working with Instances
var object_getClassName = function(/*id*/ anObject)
{
    if (!anObject)
        return "";
    var theClass = anObject.isa;
    return theClass ? class_getName(theClass) : "";
}
//objc_getClassList
var objj_lookUpClass = function(/*String*/ aName)
{
    var theClass = REGISTERED_CLASSES[aName];
    return theClass ? theClass : Nil;
}
var objj_getClass = function(/*String*/ aName)
{
    var theClass = REGISTERED_CLASSES[aName];
    /*if (!theClass)
    {
        for (var key in REGISTERED_CLASSES)
        {
            print("regClass: " + key + ", regClass.isa: " + REGISTERED_CLASSES[key].isa);
        }
        print("");
    }*/
    if (!theClass)
    {
        // class handler callback???
    }
    return theClass ? theClass : Nil;
}
var objj_getClassList = function(/*CPArray*/ buffer, /*int*/ bufferLen)
{
    for (var aName in REGISTERED_CLASSES)
    {
        buffer.push(REGISTERED_CLASSES[aName]);
        if (bufferLen && --bufferLen === 0)
            break;
    }
    return buffer.length;
}
//objc_getRequiredClass
var objj_getMetaClass = function(/*String*/ aName)
{
    var theClass = objj_getClass(aName);
    return (((theClass.info & (CLS_META))) ? theClass : theClass.isa);
}
// Working with Protocol
var objj_getProtocol = function(/*String*/ aName)
{
    return REGISTERED_PROTOCOLS[aName];
}
// Working with typeDef
var objj_getTypeDef = function(/*String*/ aName)
{
    return REGISTERED_TYPEDEFS[aName];
}
// Working with Instance Variables
var ivar_getName = function(anIvar)
{
    return anIvar.name;
}
var ivar_getTypeEncoding = function(anIvar)
{
    return anIvar.type;
}
// Sending Messages
var objj_msgSend = function(/*id*/ aReceiver, /*SEL*/ aSelector)
{
    if (aReceiver == nil)
        return aReceiver;
    var isa = aReceiver.isa;
    // Here we should do the following line: CLASS_GET_METHOD_IMPLEMENTATION(var implementation, isa, aSelector);
    // But set the 'init' attribute to 'true' when register the class pair and just check for that here is around 20% faster depending
    // on environment. The '_class_initialize' function sets the 'init' attribute to 'false' when the class is initialized
    if (isa.init)
        _class_initialize(isa);
    var method = isa.method_dtable[aSelector];
    var implementation = method ? method.method_imp : _objj_forward;
    switch(arguments.length)
    {
        case 2: return implementation(aReceiver, aSelector);
        case 3: return implementation(aReceiver, aSelector, arguments[2]);
        case 4: return implementation(aReceiver, aSelector, arguments[2], arguments[3]);
        case 5: return implementation(aReceiver, aSelector, arguments[2], arguments[3], arguments[4]);
        case 6: return implementation(aReceiver, aSelector, arguments[2], arguments[3], arguments[4], arguments[5]);
        case 7: return implementation(aReceiver, aSelector, arguments[2], arguments[3], arguments[4], arguments[5], arguments[6]);
    }
    return implementation.apply(aReceiver, arguments);
}
var objj_msgSendSuper = function(/*id*/ aSuper, /*SEL*/ aSelector)
{
    var super_class = aSuper.super_class;
    arguments[0] = aSuper.receiver;
    if (!((((super_class.info & (CLS_META))) ? super_class : super_class.isa).info & (CLS_INITIALIZED))) _class_initialize(super_class); var implementation = super_class.method_dtable[aSelector] || _objj_forward;;
    return implementation.apply(aSuper.receiver, arguments);
}
var objj_msgSendSuper0 = function(/*id*/ aSuper, /*SEL*/ aSelector)
{
    return (aSuper.super_class.method_dtable[aSelector] || _objj_forward)(aSuper.receiver, aSelector);
}
var objj_msgSendSuper1 = function(/*id*/ aSuper, /*SEL*/ aSelector, arg0)
{
    return (aSuper.super_class.method_dtable[aSelector] || _objj_forward)(aSuper.receiver, aSelector, arg0);
}
var objj_msgSendSuper2 = function(/*id*/ aSuper, /*SEL*/ aSelector, arg0, arg1)
{
    return (aSuper.super_class.method_dtable[aSelector] || _objj_forward)(aSuper.receiver, aSelector, arg0, arg1);
}
var objj_msgSendSuper3 = function(/*id*/ aSuper, /*SEL*/ aSelector, arg0, arg1, arg2)
{
    return (aSuper.super_class.method_dtable[aSelector] || _objj_forward)(aSuper.receiver, aSelector, arg0, arg1, arg2);
}
var objj_msgSendFast = function(/*id*/ aReceiver, /*SEL*/ aSelector)
{
    return (this.method_dtable[aSelector] || _objj_forward).apply(aReceiver, arguments);
}
var objj_msgSendFastInitialize = function(/*id*/ aReceiver, /*SEL*/ aSelector)
{
    _class_initialize(this);
    return this.objj_msgSend.apply(this, arguments);
}
var objj_msgSendFast0 = function(/*id*/ aReceiver, /*SEL*/ aSelector)
{
    return (this.method_dtable[aSelector] || _objj_forward)(aReceiver, aSelector);
}
var objj_msgSendFast0Initialize = function(/*id*/ aReceiver, /*SEL*/ aSelector)
{
    _class_initialize(this);
    return this.objj_msgSend0(aReceiver, aSelector);
}
var objj_msgSendFast1 = function(/*id*/ aReceiver, /*SEL*/ aSelector, arg0)
{
    return (this.method_dtable[aSelector] || _objj_forward)(aReceiver, aSelector, arg0);
}
var objj_msgSendFast1Initialize = function(/*id*/ aReceiver, /*SEL*/ aSelector, arg0)
{
    _class_initialize(this);
    return this.objj_msgSend1(aReceiver, aSelector, arg0);
}
var objj_msgSendFast2 = function(/*id*/ aReceiver, /*SEL*/ aSelector, arg0, arg1)
{
    return (this.method_dtable[aSelector] || _objj_forward)(aReceiver, aSelector, arg0, arg1);
}
var objj_msgSendFast2Initialize = function(/*id*/ aReceiver, /*SEL*/ aSelector, arg0, arg1)
{
    _class_initialize(this);
    return this.objj_msgSend2(aReceiver, aSelector, arg0, arg1);
}
var objj_msgSendFast3 = function(/*id*/ aReceiver, /*SEL*/ aSelector, arg0, arg1, arg2)
{
    return (this.method_dtable[aSelector] || _objj_forward)(aReceiver, aSelector, arg0, arg1, arg2);
}
var objj_msgSendFast3Initialize = function(/*id*/ aReceiver, /*SEL*/ aSelector, arg0, arg1, arg2)
{
    _class_initialize(this);
    return this.objj_msgSend3(aReceiver, aSelector, arg0, arg1, arg2);
}
// Working with Methods
var method_getName = function(/*Method*/ aMethod)
{
    return aMethod.method_name;
}
// This will not return correct values if the compiler does not have the option 'IncludeTypeSignatures'
var method_copyReturnType = function(/*Method*/ aMethod)
{
    var types = aMethod.method_types;
    if (types)
    {
        var argType = types[0];
        return argType != NULL ? argType : NULL;
    }
    else
        return NULL;
}
// This will not return correct values for index > 1 if the compiler does not have the option 'IncludeTypeSignatures'
var method_copyArgumentType = function(/*Method*/ aMethod, /*unsigned int*/ index)
{
    switch (index) {
        case 0:
            return "id";
        case 1:
            return "SEL";
        default:
            var types = aMethod.method_types;
            if (types)
            {
                var argType = types[index - 1];
                return argType != NULL ? argType : NULL;
            }
            else
                return NULL;
    }
}
// Returns number of arguments for a method. The first argument is 'self' and the second is the selector.
// Those are followed by the method arguments. So for example it will return 2 for a method with no arguments.
var method_getNumberOfArguments = function(/*Method*/ aMethod)
{
    var types = aMethod.method_types;
    return types ? types.length + 1 : ((aMethod.method_name.match(/:/g) || []).length + 2);
}
var method_getImplementation = function(/*Method*/ aMethod)
{
    return aMethod.method_imp;
}
var method_setImplementation = function(/*Method*/ aMethod, /*IMP*/ anImplementation)
{
    var oldImplementation = aMethod.method_imp;
    aMethod.method_imp = anImplementation;
    return oldImplementation;
}
var method_exchangeImplementations = function(/*Method*/ lhs, /*Method*/ rhs)
{
    var lhs_imp = method_getImplementation(lhs),
        rhs_imp = method_getImplementation(rhs);
    method_setImplementation(lhs, rhs_imp);
    method_setImplementation(rhs, lhs_imp);
}
// Working with Selectors
var sel_getName = function(aSelector)
{
    return aSelector ? aSelector : "<null selector>";
}
var sel_getUid = function(/*String*/ aName)
{
    return aName;
}
var sel_isEqual = function(/*SEL*/ lhs, /*SEL*/ rhs)
{
    return lhs === rhs;
}
var sel_registerName = function(/*String*/ aName)
{
    return aName;
}
var objj_styleInject = function(css) {
    if (!css) return;
    if (typeof window == 'undefined') return;
    var style = document.createElement('style');
    style.setAttribute('media', 'screen');
    style.innerHTML = css;
    document.head.appendChild(style);
    return css;
};
var objj_isString = function (obj) {
    return (obj && typeof obj === "string") || obj instanceof String;
};
var objj_isFunction = function (obj) {
    return obj && typeof obj === "function";
  };
var objj_isUndefinedOrNull = function (obj) {
    return obj === null || obj === undefined;
};
objj_class.prototype.toString = objj_object.prototype.toString = function()
{
    var isa = this.isa;
    if (class_getInstanceMethod(isa, SEL_description))
        return isa.objj_msgSend0(this, SEL_description);
    if (class_isMetaClass(isa))
        return this.name;
    return "[" + isa.name + " Object](-description not implemented)";
}
objj_class.prototype.objj_msgSend = objj_msgSendFastInitialize;
objj_class.prototype.objj_msgSend0 = objj_msgSendFast0Initialize;
objj_class.prototype.objj_msgSend1 = objj_msgSendFast1Initialize;
objj_class.prototype.objj_msgSend2 = objj_msgSendFast2Initialize;
objj_class.prototype.objj_msgSend3 = objj_msgSendFast3Initialize;
objj_class.prototype.method_msgSend = Object.create(null);
var SEL_description = sel_getUid("description"),
    SEL_forwardingTargetForSelector_ = sel_getUid("forwardingTargetForSelector:"),
    SEL_methodSignatureForSelector_ = sel_getUid("methodSignatureForSelector:"),
    SEL_forwardInvocation_ = sel_getUid("forwardInvocation:"),
    SEL_doesNotRecognizeSelector_ = sel_getUid("doesNotRecognizeSelector:"),
    SEL_invocationWithMethodSignature_ = sel_getUid("invocationWithMethodSignature:"),
    SEL_setTarget_ = sel_getUid("setTarget:"),
    SEL_setSelector_ = sel_getUid("setSelector:"),
    SEL_setArgument_atIndex_ = sel_getUid("setArgument:atIndex:"),
    SEL_returnValue = sel_getUid("returnValue");
var O = function (tagNameOrClass, props, ...children) {
    if (!tagNameOrClass) {
      return children;
    }
    if (tagNameOrClass === "_$outlet") {
      const { value, object, path } = props;
      return object.isa.objj_msgSend2(
        object,
        "setValue:forKeyPath:",
        value,
        path
      );
    }
    if(tagNameOrClass === "_$action") {
        const {target, action, sender} = props;
        sender.isa.objj_msgSend2(
            sender,
            "setTarget:",
            target
        );
        sender.isa.objj_msgSend2(
            sender,
            "setAction:",
            action
        );
        return;
    }
    const { innerHTML, nodes } = _parseChildren(...children);
    let cpObj;
    const { ref, ...rest } = props || {};
    if (objj_isString(tagNameOrClass)) {
      //TODO: init a CTView
      //   cpObj = new View({
      //     tagName: tagNameOrClass,
      //     ...(rest || {}),
      //   });
      //   if (innerHTML) {
      //     cpObj.node.innerHTML = innerHTML;
      //   }
    } else {
      if (tagNameOrClass.isa) {
        var allocator = tagNameOrClass.isa.objj_msgSend2(tagNameOrClass, "alloc");
        cpObj = allocator.isa.objj_msgSend2(
          allocator,
          "initWithProps:",
          rest || {}
        );
      }
    }
    if (cpObj) {
      if (nodes && nodes.length > 0) {
        if (!!class_getInstanceMethod(cpObj.isa, "addChild:")) {
          for (const child of nodes) {
            cpObj.isa.objj_msgSend2(cpObj, "addChild:", child);
          }
        } else {
          throw new Error(
            `${class_getName(cpObj.isa)} must implement method "addChild:".`
          );
        }
      }
      if (objj_isFunction(ref)) {
        ref(cpObj);
      }
      return cpObj;
    }
};
function _parseChildren(...children) {
    let _setInnerHtml = null,
      _children = null;
    if (children.length > 0 && objj_isString(children[0])) {
      _setInnerHtml = children.join(" ");
    } else {
      _children = children;
    }
    return {
      innerHTML: _setInnerHtml,
      nodes: _children,
    };
  }

