#import "CTObject.j"
#import "CTArray.j"

var _$MainRunLoop = Nil;

@implementation CTRunLoop : CTObject
{
    Object _observers; 

}

-(void) init {
    self = [super init];
    if (self) {
        _$MainRunLoop = self; 
        _observers = {};
    }
    return self;
}


+(CTRunLoop) mainRunLoop {
    
    if(!_$MainRunLoop) {
        _$MainRunLoop = [CTRunLoop new];
    }
    return _$MainRunLoop
}

-(void) _addObserver:(Object)observation {
    const { observed, key } = observation;
    
    const uid = [observed UID];
    
    if(!_observers[uid]) {
        _observers[uid] = {};
    }
    if(!_observers[uid][key]) {
        _observers[uid][key] = [];
    }
    
    _observers[uid][key].push(observation)
}

-(void) _removeObserver:(Object)observation {
    
    const { observed, key, target } = observation;
    const uid = [observed UID];
    if(_observers[uid]) {
        const array = _observers[uid][key]
        if(array) {
            let foundItem = nil;
            for(const item of array) {
                const itemTarget = item.target;
                if([itemTarget UID] === [target UID]) {
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

-(void) run {
    //processs all KVOs.
    const allObservations = Object.values(_observers);
    for(const uidValues of allObservations) {
        const arrays = Object.values(uidValues);
        for(const arr of arrays) {
            for(const observation of arr) {
                const { 
                    observed, 
                    target, 
                    action, 
                    key, 
                    previousValue 
                }  = observation;
                const currentValue = [observed valueForKey:key];
                if(currentValue !== previousValue) {
                    [target performSelector:action withObject:observed];
                    observation.previousValue = currentValue;
                }
            }   
        }
    }
}

@end