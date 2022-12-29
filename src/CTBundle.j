#import "CTObject.j"

var _$MainBundle = nil;

@implementation CTBundle : CTObject

+(CTBundle) mainBundle 
{
    if(!_$MainBundle) {
        _$MainBundle = [CTBundle new];
    }
    return _$MainBundle; 
}

-(void) injectStyles 
{
    if(__$objj_bundle) {
        const styles = Object.values(__$objj_bundle.styles);
        for(const style of styles) {
            objj_styleInject(style);      
        }  
    }
}

-(String) base64ForResourceNamed:(String)resourceName 
{
    if(__$objj_bundle) {
        if(__$objj_bundle.resources[resourceName]){
           return __$objj_bundle.resources[resourceName];
        };
     }
     throw new Error(`No resource with name "${resourceName}" found in main bundle.`);
}

-(BOOL) loadCibNamed:(String)cibName owner:(id)anObject 
{
    if(__$objj_bundle) {
        if(__$objj_bundle.cibs[cibName]){
           const code =  __$objj_bundle.cibs[cibName];
           if(code) {
            var owner = (@deref(anObject) = eval(code));  
            if([owner respondsToSelector:@selector(awakeFromCib)]){
                [owner performSelector:@selector(awakeFromCib)];
            }
            return YES;
           } 
        };
     }
     return NO;
}

-(Object) info 
{
    if(__$objj_bundle) {
        return __$objj_bundle.info;
    }
}

-(id) copy 
{
    return self; 
}

@end