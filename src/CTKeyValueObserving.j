#import "CTObject.j"
#import "CTArray.j"

@implementation CTObject (KVO)
 
-(void) addObserver:(id)anObject forKey:(String)aKey action:(Selector)aSelector {
    
    if (!anObserver || !aKey)
        return;

    if(!self._$observers) {
        self._$observers = {};
    }
    if(!self._$observers[aKey]) {
        self._$observers[aKey] = [];
    }

    self._$observers.push({
        target: anObject,
        action:aSelector,
        keyPath: aKey,
        cachedValue: [self valueForKey:aKey]
    });
}

-(void) addObserver:(id)anObject forKeyPath:(String)aPath action:(Selector)aSelector {

    if (!anObserver || !aKey)
        return;
    
    const firstDotIndex = aPath.indexOf(".");
    
    if(firstDotIndex < 0) {
        return [self addObserver:anObject forKey:aPath action:aSelector];
    }

    const firstKeyComponent = aPath.substring(0, firstDotIndex),
        remainingKeyPath = aPath.substring(firstDotIndex + 1),
        value = [self valueForKey:firstKeyComponent];

    [value addObserver:anObject forKeyPath:remainingKeyPath action:aSelector];    

}

-(void) removeObserver:(id)anObject forKey:(String)aKey {
    if (!anObserver || !aKey)
        return;

    if(self._$observers) {
        if(self._$observers[aKey]) {
            [self._$observers[aKey] removeObject:anObject];
        }

        if(self._$observers[aKey].length === 0) {
            delete self._$observers[aKey];
        }

        if(Object.keys(self._$observers).length === 0) {
            delete self._$observers;
        }
    }    
}

-(void) removeObserver:(id)anObject forKeyPath:(String)aPath {

    if (!anObserver || !aPath)
        return;

    const firstDotIndex = aPath.indexOf(".");
    if(firstDotIndex < 0) {
        return [removeObserver:anObject forKey:aPath];
    }

    const firstKeyComponent = aPath.substring(0, firstDotIndex),
        remainingKeyPath = aPath.substring(firstDotIndex + 1),
        value = [self valueForKey:firstKeyComponent];

    [value removeObserver:anObject forKeyPath:remainingKeyPath];
}

@end

