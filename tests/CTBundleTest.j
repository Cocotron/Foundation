#import "../src/Foundation.j"



var theBundle = [CTBundle mainBundle];

var  myObj;

@implementation AController : CTObject
{
    @outlet CTArray anArray;
}



@end



if([theBundle loadCibNamed:@"MyCib" owner:@ref(myObj)]){

    [myObj.anArray addObject:"Hello"];
    [myObj.anArray addObject:"World"];  

    console.log(myObj);
}




