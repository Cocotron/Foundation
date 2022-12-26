#import "CTObject.j"
#import "CTNotification.j"
#import "CTArray.j"

var _$CTNotificationDefaultCenter = nil;

@implementation CTNotificationCenter : CTObject
{
    Object _objectObservers; 
}

+(CTNotificationCenter) defaultCenter 
{
    if(!_$CTNotificationDefaultCenter) {
        _$CTNotificationDefaultCenter = [[CTNotificationCenter alloc] init];
    }
    return _$CTNotificationDefaultCenter;
}

-(id) init {
    self = [super init];
    if( self ) {
        _objectObservers = {};
    }
    return self;
}


- (void)addObserver:(id)anObserver selector:(SEL)aSelector name:(String)aNotificationName object:(id)anObject
{
     const uid = [anObserver UID];
     if(!_objectObservers[aNotificationName]) {
        _objectObservers[aNotificationName] = {};
     }

     if(!_objectObservers[aNotificationName][uid]) {
        _objectObservers[aNotificationName][uid] = [];
     }

     _objectObservers[aNotificationName][uid].push({
        target: anObserver,
        action: aSelector,
        source: anObject
     });

     console.log(_objectObservers);
}

- (void)addObserver:(id)anObserver selector:(SEL)aSelector name:(String)aNotificationName
{
    [self addObserver:anObserver selector:aSelector name:aNotificationName object:nil];
}

- (void)removeObserver:(id)anObserver name:(String)aNotificationName object:(id)anObject
{
    const uid = [anObserver UID];
    if (!aNotificationName) {
        const notifications = Object.keys(_objectObservers);
        for(const notif of notifications) {
            delete notif[uid];
        }
    }
    else {
        if(_objectObservers[aNotificationName]) {
            if(_objectObservers[aNotificationName][uid]) {
                if(!anObject) {
                    delete _objectObservers[aNotificationName][uid];
                }
                else {
                    const observerations = _objectObservers[aNotificationName][uid];
                    const objectUID = [anObject UID];
                    const foundItem = nil;
                    for(const obs of observerations) {
                        if([obs.source UID] === objectUID) {
                            foundItem = obs;
                            break;
                        }
                    }
                    if(foundItem) {
                        [observerations removeObject:foundItem];
                    } 
                    if(observerations.length === 0) {
                        delete _objectObservers[aNotificationName][uid];
                    }
                } 
            } 
        } 
    }
}

- (void)removeObserver:(id)anObserver 
{
    [self removeObserver:anObserver name:nil object:nil];
}

-(void) postNotification:(CTNotification)aNotification 
{
    if(aNotification) {
        const name = [aNotification name];
        const fromObjectUID = [[aNotification object] UID];
        if(_objectObservers[name]) {
            const observers = _objectObservers[name]; 
            for(const observer in observers) {
                const observations = observers[observer];
                for(const obs of observations) {
                    if(!obs.source || fromObjectUID === [obs.source UID]) {
                        [obs.target performSelector:obs.action withObject:aNotification];
                    } 
                }
            }
        }
    }
}

-(void) postNotificationName:(String)aName object:(id)anObject userInfo:(Object)userInfo 
{
    [self postNotification:[CTNotification notificationWithName:aName object:anObject userInfo:userInfo]];
}

-(void) postNotificationName:(String)aName object:(id)anObject  
{
    [self postNotification:[CTNotification notificationWithName:aName object:anObject userInfo:nil]];
}

-(void) postNotificationName:(String)aName  
{
    [self postNotification:[CTNotification notificationWithName:aName object:nil userInfo:nil]];
}

@end
