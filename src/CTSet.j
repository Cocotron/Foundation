
#import "CTObject.j"

@implementation CTSet : CTObject

+(id) alloc {
    return new Set();
}

+(id) set {
    return new Set();
}

+(id) setWithObjects:(id)anObject, ... 
{
    var index = 2,
        count = arguments.length;
    for (; index < count; ++index)
        if (arguments[index] === nil)
            break;
    return new Set(Array.prototype.slice.call(arguments, 2, index));        
}

-(void) addObject:(id)anObject {
    self.add.call(self, anObject);
}

-(void) removeObject:(id)anObject {
    self.delete.call(self, anObject);
}

-(void) removeAllObjects {
    self.clear.call(self);
}

-(BOOL) containsObject:(id)anObject {
    return self.has.call(self, anObject);
}

-(Integer) count {
    return self.size;
}

-(CTSet) copy 
{
    const theCopy = new Set();
    for(const item of self) {
        if(item.isa) {
            theCopy.add([item copy]);
        }
        else {
            theCopy.add(item);
        }
    }
    return theCopy;
}


@end

Set.prototype.isa = CTSet;