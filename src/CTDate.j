#import "CTObject.j"

@implementation CTDate : CTObject

+ (id)alloc
{
    var result = new Date;
    result.isa = [self class];
    return result;
}

+ (id)date
{
    return [[self alloc] init];
}

-(id) initWithProps:(Object) props {
    self = [super init];
    if( self ) {
        if(props.time) {
            self.setTime.call(self, props.time);
        }
    }
    return self; 
}

+(id) dateWithMonth:(Integer)month day:(Integer)day year:(Integer)year {
    var date = [CTDate date];

    [date resetTime];
    [date setYear:year];
    [date setMonth:month];
    [date setDate:day];
    
    return date; 
}

-(long) time {
    return self.getTime.call(self);
}

-(void) setDate:(Integer)date { 
    self.setDate.call(self, date);
}

-(Integer) date {
    return self.getDate.call(self);
}

-(Integer) day {
    return self.getDay.call(self);
}

/**
    Sets the month, not zero based, ie
    1- Jan
    2- Feb
    3 - March,...
*/
-(void) setMonth:(Integer)monthIndex { 
    self.setMonth.call(self, monthIndex-1);
}

-(Integer) month {
    return self.getMonth.call(self);
}

-(void) setYear:(Integer) year {
    self.setFullYear.call(self, year);
}

-(Integer) year  {
    return self.getFullYear.call(self);
}

-(void) setHours:(Integer) hours {
    self.setHours.call(self, hours);
}

-(Integer) hours {
    return self.getHours.call(self);
}

-(void) setMinutes:(Integer) minutes {
    self.setMinutes.call(self, minutes);
}

-(Integer) minutes {
    return self.getMinutes.call(self);
}

-(void) setSeconds:(Integer) seconds {
    self.setSeconds.call(self, seconds);
}

-(Integer) seconds {
    return self.getSeconds.call(self);
}

/**
    Resets the date to midnight
*/
-(void) resetTime {
    const mSec = self.getTime();
    let offset = mSec % 1000;
    // Normalize if time is before epoch
    if (offset < 0) {
      offset += 1000;
    }
    self.setTime(mSec - offset);
    self.setHours(0);
    self.setMinutes(0)
    self.setSeconds(0);
}

-(CTDate) copy {
    return copyDate(self);
}

@end

Date.prototype.isa = CTDate; 
