#import "CTObject.j"
#import "CTDictionary.j"

@implementation CTNotification : CTObject
{
     String         _name @accessors(property=name,  readonly);
     id             _object @accessors(property=object, readonly);
     Object         _userInfo @accessors(property=userInfo, readonly);

}

+(CTNotification) notificationWithName:(String)aName object:(id)anObject userInfo:(Object)userInfo 
{
    return [[self alloc] initWithName:aName object:anObject userInfo:userInfo];
}


+(CTNotification) notificationWithName:(String)aName object:(id)anObject 
{
    return [[self alloc] initWithName:aName object:anObject userInfo:nil];
}


-(id) initWithName:(String)aName object:(id)anObject userInfo:(Object)userInfo 
{
    self = [super init];

    if( self ) {
        _name = aName;
        _object = anObject;
        _userInfo = userInfo;
    }

    return self;
}

@end
