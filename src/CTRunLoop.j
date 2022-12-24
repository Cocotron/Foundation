#import "CTObject.j"


var _$MainRunLoop = null;

@implementation CTRunLoop : CTObject
{
    
}


+(CTRunLoop) mainRunLoop {
    if(!_$MainRunLoop) {
        _$MainRunLoop = [CTRunLoop new];
    }
    return _$MainRunLoop
}



@end