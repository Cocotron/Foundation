
#import "CTObject.j"
#import "CTDictionary.j"

@implementation CTObject (KVC)
 
-(id) valueForKey:(String)aKey {

    if([self respondsToSelector:@selector(aKey)]) {
        return [self performSelector:@selector(aKey)];
    }

    if(self[aKey]) {
        return self[aKey];
    }

    throw new Error(`${[self class]} does not respond to key ${aKey}`);
}

- (id)valueForKeyPath:(CPString)aKeyPath
{
    const firstDotIndex = aKeyPath.indexOf(".");

    if (firstDotIndex < 0)
        return [self valueForKey:aKeyPath];

    const firstKeyComponent = aKeyPath.substring(0, firstDotIndex),
        remainingKeyPath = aKeyPath.substring(firstDotIndex + 1),
        value = [self valueForKey:firstKeyComponent];

    return [value valueForKeyPath:remainingKeyPath];
}

-(void) setValue:(id)aValue forKey:(String)aKey {

    var capitalizedKey = aKey.charAt(0).toUpperCase() + aKey.substring(1),
        _selector = sel_getUid("set" + capitalizedKey + ":");
    if([self respondsToSelector:_selector]) {
        [self performSelector:_selector withObject:aValue]; 
    }
    else {
        self[aKey] = aValue; 
    }
    
    
}

-(void) setValue:(id)aValue forKeyPath:(String)aKeyPath {

    if (!aKeyPath)
        aKeyPath = @"self";

    const firstDotIndex = aKeyPath.indexOf(".");

    if (firstDotIndex < 0)
        return [self setValue:aValue forKey:aKeyPath];

    const firstKeyComponent = aKeyPath.substring(0, firstDotIndex),
          remainingKeyPath = aKeyPath.substring(firstDotIndex + 1),
          value = [self valueForKey:firstKeyComponent];

    return [value setValue:aValue forKeyPath:remainingKeyPath];
}

@end


@implementation CTDictionary (KVC)
 
- (id)valueForKey:(String)aKey
{
    return [self objectForKey:aKey];
}

- (void)setValue:(id)aValue forKey:(String)aKey
{
    if (aValue != nil)
        [self setObject:aValue forKey:aKey];
    else
        [self removeObjectForKey:aKey];
}

@end