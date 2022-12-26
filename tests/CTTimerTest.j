
#import "../src/CTTimer.j"

let counter = 0;

var timer = [CTTimer scheduleTimerWithInterval:500 callback:function() {

    console.log("Timer is firing!")
    counter++;

    if(counter > 3) {
        [timer cancel];
    }

} repeats:YES];