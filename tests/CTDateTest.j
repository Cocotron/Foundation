

#import "../src/CTDate.j"
#import "../src/CTDateFormatter.j"


var date = [CTDate dateWithMonth:1 day:7 year:1978];

const fmt = [CTDateFormatter formatDate:date locale:undefined 
    usingTemplate:"MMMM d, YYYY"];

console.log(fmt);

const fmt2 = [CTDateFormatter formatDate:date usingTemplate:"MM/dd/YYYY"];

console.log(fmt2);