#import "CTObject.j"
#import "CTArray.j"
#import "CTNumber.j"


var _$KVObservers = {};

@implementation CTObject (KVO)
 
-(void) addObserver:(id)anObserver forKey:(String)aKey action:(SEL)aSelector {
    
    if (!anObserver || !aKey)
        return;

    const uid = [self UID];
    if(!_$KVObservers[uid]) {
        _$KVObservers[uid] = {};
    }
    if(!_$KVObservers[uid][aKey]) {
        _$KVObservers[uid][aKey] = [];
    }
    _$KVObservers[uid][aKey].push({
        target: anObserver,
        action: aSelector,
        key: aKey,
        previousValue: [self valueForKey:aKey],
        observed: self     
    });   
}

-(void) addObserver:(id)anObserver forKeyPath:(String)aPath action:(SEL)aSelector {

    if (!anObserver || !aPath)
        return;
    
    const firstDotIndex = aPath.indexOf(".");
    
    if(firstDotIndex < 0) {
        return [self addObserver:anObserver forKey:aPath action:aSelector];
    }

    const firstKeyComponent = aPath.substring(0, firstDotIndex),
        remainingKeyPath = aPath.substring(firstDotIndex + 1),
        value = [self valueForKey:firstKeyComponent];

    [value addObserver:anObserver forKeyPath:remainingKeyPath action:aSelector];    

}

-(void) removeObserver:(id)anObserver forKey:(String)aKey {
    
    if (!anObserver || !aKey)
        return;

    const uid = [self UID];
    if(_$KVObservers[uid]) {
        const array = _$KVObservers[uid][aKey]
        if(array) {
            let foundItem = Nil;
            for(const item of array) {
                const target = item.target;
                if([target UID] === [anObserver UID]) {
                    foundItem = item;
                    break;
                }
            }
            if(foundItem) {
                [array removeObject:foundItem];
            }
        }
     }   
}

-(void) removeObserver:(id)anObserver forKeyPath:(String)aPath {

    if (!anObserver || !aPath)
        return;

    const firstDotIndex = aPath.indexOf(".");
    if(firstDotIndex < 0) {
        return [self removeObserver:anObserver forKey:aPath];
    }

    const firstKeyComponent = aPath.substring(0, firstDotIndex),
        remainingKeyPath = aPath.substring(firstDotIndex + 1),
        value = [self valueForKey:firstKeyComponent];

    [value removeObserver:anObserver forKeyPath:remainingKeyPath];
}

@end

