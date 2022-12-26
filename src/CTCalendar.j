#import "CTObject.j"
#import "CTDate.j"
#import "DateUtils.j"

const DAYS_IN_WEEK = 7;
const MONTHS_IN_YEAR = 12;
const MAX_DAYS_IN_MONTH = 32;

@implementation CTCalendar : CTObject
{
    CTDate _currentMonth;

    CTArray dayOfWeekNames @accessors(readonly); 
    CTArray monthOfYearNames @accessors(readonly);

}

-(id) init 
{
      self = [super init];
      if( self ) {
        dayOfWeekNames = [];
        monthOfYearNames = [];
        // Finding day of week names
        let date = new Date();
        for (let i = 1; i <= DAYS_IN_WEEK; i++) {
            date.setDate(i);
            let dayOfWeek = date.getDay();
            dayOfWeekNames.push(date.toLocaleString("default", {
                weekday: "short",
            });
        }
        // finding month names
        date.setDate(1);
        for (let i = 0; i < MONTHS_IN_YEAR; i++) {
            date.setMonth(i);
            monthOfYearNames.push(date.toLocaleString("default", { month: "long" }));
        } 
     }
     return self; 
}

-(void) setCurrentMonth:(CTDate)date 
{
    [_currentMonth setMonth:[date month]];
    [_currentMonth setYear:[date year]];
}

-(CTDate) currentMonth 
{
    return _currentMonth;
}

-(CTArray) monthNames 
{
    return monthOfYearNames;
}

-(CTArray) dayNames 
{
    return dayOfWeekNames;
}

-(CTDate) currentFirstDayOfFirstWeek 
{
  let wkDayOfMonth1st = [_currentMonth day];
  let start = 0;
  if (wkDayOfMonth1st === start) {
    // always return a copy to allow SimpleCalendarView to adjust first
    // display date
    return new Date([_currentMonth time]);
  } else {
    let d = new Date([_currentMonth time]);
    let offset =
      wkDayOfMonth1st - start > 0
        ? wkDayOfMonth1st - start
        : DAYS_IN_WEEK - (start - wkDayOfMonth1st);
    addDaysToDate(d, -offset);
    return d;
  }
}

@end
