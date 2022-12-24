
#import "CTObject.j"
#import "CTArray.j"

@implementation CTDictionary : CTObject

+(id) alloc 
{
    return new Map();
}

+(id) dictionary {
    return new Map();
}

-(CTArray) allKeys
{
    return Array.from(self.keys.call(self));
}

-(CTArray) allObjects
{
    return Array.from(self.values.call(self))
}

-(BOOL) containsKey:(String)aKey 
{
    return self.has.call(self, aKey);
}

-(id) objectForKey:(String)aKey 
{
    return self.get.call(self, aKey);
}

-(void) setObject:(id)anObject forKey:(String)aKey 
{
    self.set.call(self, aKey, anObject);
} 

-(void) removeObjectForKey:(String)aKey {
    self.delete.call(self, aKey);
}

-(Integer) count 
{
    return self.size.call(self);
}

@end

Map.prototype.isa = CTDictionary;