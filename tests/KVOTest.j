#import "../src/CTKeyValueCoding.j";
#import "../src/CTKeyValueObserving.j"
#import "../src/CTNumber.j"
#import "../src/CTString.j"
#import "../src/CTRunLoop.j"
 
@implementation Pet : CTObject
{
   String name;
}

@end

@implementation Person : CTObject
{
    Number  age         @accessors;
    Pet     pet         @accessors; 
    Object  info;
}

-(id) init {

    self = [super init];

    pet = [Pet new];
    pet.name = "Ringo";
    info = {tag: "3"};

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


var p = [[Person alloc] initWithProps:{
    age: 20
}];
 
p.pet.name = @"Carter"; 
console.log([p age])

console.log([p respondsToSelector:@"age"]);
//alert([p valueForKeyPath:@"pet.name"])

const observer = [AnObserver new];

[p addObserver:observer forKeyPath:@"age" action:@selector(didChange:)];

console.log([p.age UID]);

var n = [CTNumber new];
console.log("n = " + n)

p.age = 50;

console.log([CTRunLoop mainRunLoop]);

[[CTRunLoop mainRunLoop] run];

[p removeObserver:observer forKeyPath:@"age"];

p.age = 20;

[[CTRunLoop mainRunLoop] run]; 


var p2 = [p copy];

p2.age = 35;

[p2 setValue:@"Dooley" forKeyPath:@"pet.name"];

console.log("person 1's age is " + p.age);
console.log("person 2's age is " + p2.age);

console.log("person 1's pets name is " + p.pet.name);
console.log("person 2's pets name is " + p2.pet.name);

const d = [CTDictionary dictionary];

[d setObject:p forKey:@"Person1"];
[d setObject:p2 forKey:@"Person2"];

const d2 = [d copy];

const p3 = [d2 objectForKey:@"Person1"];
[p3 setAge:44];

console.log("person 1's age is " + p.age);
console.log("person 2's age is " + p2.age);
console.log("person 3's age is " + p3.age); 

