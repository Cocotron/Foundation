#import "CTObject.j"
#import "CTRunLoop.j"

@implementation CTTimer : CTObject
{
    Integer _timeInterval;
    Function _callback;
    BOOL _repeats;
    BOOL _invalid; 

    Object _nativeTimer; 

}

+(CTTimer) timerWithInterval:(Integer)milliseconds callback:(Function)callback repeats:(BOOL)repeats {
    return [[self alloc] initWithInterval:milliseconds callback:callback repeats:repeats];
}

+(CTTimer) scheduleTimerWithInterval:(Integer)milliseconds callback:(Function)callback repeats:(BOOL)repeats {
    const timer = [[self alloc] initWithInterval:milliseconds callback:callback repeats:repeats];
    [timer fire];
    return timer; 
}

-(id) initWithInterval:(Integer)milliseconds callback:(Function)callback repeats:(BOOL)repeats {
    self = [super init];
    if ( self ) {
        _timeInterval = milliseconds;
        _callback = callback;
        _repeats = repeats;
        _invalid = NO; 
    }
    return self; 
}

-(void) fire {
    _invalid = NO;
    if(_repeats) {
        _nativeTimer = setInterval(function(){
            if(_callback && !_invalid) {
                _callback.bind({self: self});
                _callback.call(self);
                [[CTRunLoop mainRunLoop] run];
            }
        }, _timeInterval)
    }
    else {
     _nativeTimer = setTimeout(function(){
            if(_callback && !_invalid) {
                _callback.call(self);
                [[CTRunLoop mainRunLoop] run];
            }
        }, _timeInterval);
    }
}

-(void) cancel {
    _invalid = YES; 
    clearTimeout(_nativeTimer);
    clearInterval(_nativeTimer);
}



@end