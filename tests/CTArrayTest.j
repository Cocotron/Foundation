#import "../src/CTArray.j"

//Test Array
let array = [CTArray arrayWithObjects:@"One", @"Two", @"Three"];

[array addObject:"Hello2"];

[array insertObject:"Dog" atIndex:2];


[array addObject:nil];

console.log("CTArray:");
console.log(array);

[array removeAt:0];



console.log([array count])   ;   