

#import "../src/CTNotificationCenter.j"


var notifCenter = [CTNotificationCenter defaultCenter];

@implementation TestObject : CTObject
{
   
}

-(void) fireAHello:(CTNotification)aNotification {
    alert("hello")
}

@end

var testObj = [TestObject new];


[notifCenter addObserver:testObj selector:@selector(fireAHello:) name:@"TestNotification"];


[notifCenter postNotificationName:@"TestNotification"]