#import "../src/CTIndexSet.j"


var indexSet = [CTIndexSet indexSetWithIndexesInRange:CTMakeRange(5, 10)];
console.log([indexSet containsIndex:11]);
console.log([indexSet containsIndex:20]);
for(const idx of indexSet) {
    console.log(idx);
}