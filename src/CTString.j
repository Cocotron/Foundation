
#import "CTObject.j"

var _$CPStringUIDs = {};

@implementation CTString : CTObject
 
+ (id)alloc
{
    if ([self class] !== CTString)
       return [super alloc];

    return new String;
}

+(id) string {
    return [[self alloc] init];
}


-(Integer) length {
    return self.length;
}

- (CTString)substringFromIndex:(unsigned)anIndex
{
    return self.substring(anIndex);
}

- (CPString)substringToIndex:(unsigned)anIndex
{
    if (anIndex > self.length)
        throw new Error("index out of bounds");

    return self.substring(0, anIndex);
}

- (CTString)capitalizedString
{
    var parts = self.split(/\b/g), // split on word boundaries
        i = 0,
        count = parts.length;

    for (; i < count; i++)
    {
        if (i == 0 || (/\s$/).test(parts[i - 1])) // only capitalize if previous token was whitespace
            parts[i] = parts[i].substring(0, 1).toUpperCase() + parts[i].substring(1).toLowerCase();
        else
            parts[i] = parts[i].toLowerCase();
    }
    return parts.join("");
}

- (CTString)uncapitalizedString
{
    var parts = self.split(/\b/g), // split on word boundaries
        i = 0,
        count = parts.length;

    for (; i < count; i++)
    {
        if (i == 0 || (/\s$/).test(parts[i - 1])) 
            parts[i] = parts[i].substring(0, 1).toLowerCase() + parts[i].substring(1).toLowerCase();
        else
            parts[i] = parts[i].toLowerCase();
    }
    return parts.join("");
}

- (CTString)lowercaseString
{
    return self.toLowerCase();
}

 
- (CTString)uppercaseString
{
    return self.toUpperCase();
}

- (CPString)UID
{
    var UID = _$CPStringUIDs[self];

    if (!UID)
    {
        UID = objj_generateObjectUID();
        _$CPStringUIDs[self] = UID;
    }

    return UID + "";
}


@end

String.prototype.isa = CTString;
