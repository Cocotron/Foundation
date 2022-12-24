
#import "../src/CTSet.j"


var aSet = [CTSet setWithObjects:@"One", @"Two"];

[aSet addObject:@"Hello"]
[aSet addObject:@"World"]
[aSet addObject:@"Test"]

console.log("Set:");
console.log(aSet);

console.log([aSet count]);

[aSet removeObject:@"Test"];
console.log(aSet);

console.assert([aSet containsObject:@"World"]);
console.assert(![aSet containsObject:@"Blah"]);

for(const obj of aSet) {
    console.log(obj);
}
