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
        const stylesArray = __$objj_bundle.styles;
        for(const style of stylesArray) {
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

-(id) copy 
{
    return self; 
}

@end