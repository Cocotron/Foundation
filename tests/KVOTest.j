#import "../src/CTKeyValueCoding.j";


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


var p = [Person new];
 
p.pet.name = @"Carter";
p.age = 20;

console.log([p respondsToSelector:@"age"]);
alert([p valueForKeyPath:@"pet.name"])

[p setValue:@"Oksana" forKeyPath:@"pet.name"];

alert(p.pet.name);