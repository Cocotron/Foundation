#import "CTSet.j"

class _$CountedSet extends Set {}

@implementation CTCountedSet : CTObject
{
    Object _counts;  
}

+(id) alloc {
    return new _$CountedSet();
}

+(CTCountedSet) set {
    return new _$CountedSet();
}

 
-(BOOL) containsObject:(id)anObject {
    return self.has.call(self, anObject);
}

-(Integer) count {
    return self.size;
}

- (void)addObject:(id)anObject
{
    if (!_counts)
        _counts = {};

    self.add.call(self, anObject);

    var UID = [anObject UID];

    if (_counts[UID] === undefined)
        _counts[UID] = 1;
    else
        ++_counts[UID];
}

- (void)removeObject:(id)anObject
{
    if (!_counts)
        return;

    var UID = [anObject UID];

    if (_counts[UID] === undefined)
        return;

    else
    {
        --_counts[UID];

        if (_counts[UID] === 0)
        {
            delete _counts[UID];
            self.delete.call(self, anObject);
        }
    }
}

- (void)removeAllObjects
{
     self.clear.call(self);
    _counts = {};
}

- (Integer)countForObject:(id)anObject
{
    if (!_counts)
        _counts = {};

    var UID = [anObject UID];

    if (_counts[UID] === undefined)
        return 0;

    return _counts[UID];
}

-(CTSet) copy 
{
    const theCopy = new _$CountedSet();
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

_$CountedSet.prototype.isa = CTCountedSet;