

#import "../src/CTNotificationCenter.j"


var notifCenter = [CTNotificationCenter defaultCenter];

@implementation TestObject : CTObject
{
   String _marker;
}

+(id) testObjWithMarker:(String)marker {
    let obj = [TestObject new];
    obj._marker = marker;
    return obj; 
}


-(void) fireAHello:(CTNotification)aNotification {
    console.log("from object with marker " + _marker)
    const { message } = [aNotification userInfo];
    alert(message);
}

@end

var testObj0 = [TestObject testObjWithMarker:@"Zero"];
var testObj1 = [TestObject testObjWithMarker:@"ONE"];
var testObj2 = [TestObject testObjWithMarker:@"TWO"];
var testObj3 = [TestObject testObjWithMarker:@"THREE"];

const NotificationName = @"TestNotification";

[notifCenter addObserver:testObj0 selector:@selector(fireAHello:) name:NotificationName object:testObj2];
[notifCenter addObserver:testObj1 selector:@selector(fireAHello:) name:NotificationName object:testObj3];


[notifCenter postNotificationName:NotificationName object:testObj2 userInfo:{
    message: "Hey"
}];

//[notifCenter removeObserver:testObj1 name:NotificationName object:testObj3];

[notifCenter postNotificationName:NotificationName object:testObj3 userInfo:{
    message: "sup"
}];