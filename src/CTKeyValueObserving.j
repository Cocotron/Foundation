#import "CTObject.j"
#import "CTArray.j"
#import "CTNumber.j"
#import "CTRunLoop.j"

@implementation CTObject (KVO)
 
-(void) addObserver:(id)anObserver forKey:(String)aKey action:(Selector)aSelector {
    
    if (!anObserver || !aKey)
        return;
   
    [[CTRunLoop mainRunLoop] _addObserver:{
        target: anObserver,
        action: aSelector,
        key: aKey,
        previousValue: [self valueForKey:aKey],
        observed: self 
    }];
}

-(void) addObserver:(id)anObserver forKeyPath:(String)aPath action:(Selector)aSelector {

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

        [[CTRunLoop mainRunLoop] _removeObserver:{
            target: anObserver, 
            key: aKey, 
            observed: self 
        }];
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

