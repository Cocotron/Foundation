#import "CTObject.j"
#import "CTArray.j"
#import "CTKeyValueObserving.j"

var _$MainRunLoop = Nil;

var _$RunKVOProcessor = function() {
    const all = Object.values(_$KVObservers);
    for(const uidValues of all) {
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
};

@implementation CTRunLoop : CTObject
{
     
}

-(void) init {
    self = [super init];
    if (self) {
        _$MainRunLoop = self;  
    }
    return self;
}


+(CTRunLoop) mainRunLoop {
    
    if(!_$MainRunLoop) {
        _$MainRunLoop = [CTRunLoop new];
    }
    return _$MainRunLoop
}
 

-(void) run {
    _$RunKVOProcessor();
}
 
@end