#import "CTObject.j"

#define CAST_TO_INT(x) ((x) >= 0 ? Math.floor((x)) : Math.ceil((x)))

var _$CTNumberUIDs    = {};

@implementation CTNumber : CTObject

+ (id) alloc
{
    var result = new Number();
    result.isa = [self class];
    return result;
}

+ (id)numberWithChar:(char)aChar
{
    if (aChar.charCodeAt)
        return aChar.charCodeAt(0);

    return aChar;
}
 
- (char)charValue
{
    return String.fromCharCode(self);
}

- (String)UID
{
    var UID = _$CTNumberUIDs[self];

    if (!UID)
    {
        UID = objj_generateObjectUID();
        _$CTNumberUIDs[self] = UID;
    }

    return UID + "";
}

- (String)description
{
    return self.toString();
}

- (double)doubleValue
{
    if (typeof self == "boolean")
        return self ? 1 : 0;

    return self;
}

- (int)integerValue
{
    return CAST_TO_INT(self);
}

@end


Number.prototype.isa = CTNumber;
Boolean.prototype.isa = CTNumber;
