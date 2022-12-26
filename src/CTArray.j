
#import "CTObject.j"
#import "CTNumber.j"

@implementation CTArray : CTObject

+ (id)alloc
{
    return [];
}

+ (id)array
{
    return [];
}

+(id) arrayWithObjects:(id)anObject, ... 
{
    var index = 2,
        count = arguments.length;
    for (; index < count; ++index)
        if (arguments[index] === nil)
            break;
    return Array.prototype.slice.call(arguments, 2, index);        
}


-(void) addObject:(id)anObject 
{
    self.push.call(self, anObject);
}

-(void) insertObject:(id)anObject atIndex:(Integer)anIndex 
{
    self.splice.call(self, anIndex, 0, anObject);
}

- (void)replaceObjectAtIndex:(Integer)anIndex withObject:(id)anObject
{
    if (anIndex >= self.length || anIndex < 0)
        throw new Error(`Out of range error: ${anIndex}`);

    self[anIndex] = anObject;
}

-(void) removeObject:(id)anObject
{
    var anIndex;
    while ((anIndex = self.indexOf.call(self, anObject)) !== -1)
            self.splice.call(self, anIndex, 1);
}

-(void) removeAt:(Integer)anIndex 
{
    self.splice.call(self, anIndex, 1);
}

-(void) removeObjectsInRange:(CTRange)aRange {
    if (aRange.location < 0 || CPMaxRange(aRange) > self.length)
        throw new Error(_cmd + " aRange out of bounds");

    self.splice.call(self, aRange.location, aRange.length);
}

- (void)removeLastObject
{
    self.pop.call(self);
}

-(void) removeAllObjects 
{
    self.splice.call(self, 0, self.length);
}



-(Integer) count {
    return self.length; 
}

@end

Array.prototype.isa = CTArray;
