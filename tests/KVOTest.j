#import "../src/CTKeyValueCoding.j";
#import "../src/CTKeyValueObserving.j"
#import "../src/CTNumber.j"
 
@implementation Pet : CTObject
{
   String name;
}

@end

@implementation Person : CTObject
{
    Integer age         @accessors;
    Pet     pet         @accessors; 
}

-(id) init {

    self = [super init];

    pet = [Pet new];

    return self;
}
@end

@implementation AnObserver : CTObject
{
    
}

-(void) didChange:(id)sender {
    console.log(`change from ${sender}`)
    console.log([sender valueForKey:@"age"]);
}

@end


var p = [Person new];
 
p.pet.name = @"Carter";
p.age = 20;

console.log([p respondsToSelector:@"age"]);
alert([p valueForKeyPath:@"pet.name"])

const observer = [AnObserver new];

[p addObserver:observer forKeyPath:@"age" action:@selector(didChange:)];

console.log([p.age UID]);

p.age = 50;

console.log([CTRunLoop mainRunLoop]);

[[CTRunLoop mainRunLoop] run];

[p removeObserver:observer forKeyPath:@"age"];

p.age = 20;

[[CTRunLoop mainRunLoop] run]; 