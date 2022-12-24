
#import "../src/CTCountedSet.j"

console.log("CTCountedSet:");

var countedSet = [CTCountedSet set];

[countedSet addObject:@"Times"];
[countedSet addObject:@"Hello"];
[countedSet addObject:@"Times"];
[countedSet addObject:@"Blah"];

console.log([countedSet countForObject:@"Times"]);

for(const x of countedSet) {
    console.log(x);
}