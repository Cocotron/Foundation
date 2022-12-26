#import "CTDate.j"

function isLeapYear(year) {
    return (year % 4 === 0 && year % 100 !== 0) || year % 400 === 0;
}

function numberOfDaysInMonth(month, year) {
    return [
      31,
      [self isLeapYear:year] ? 29 : 28,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31,
    ][month];
}

function addMonthsToDate(date, months) {
    if (months !== 0) {
        let n = date.getDate();
        date.setDate(1);
        date.setMonth(date.getMonth() + months);
        date.setDate(
          Math.min(n, getDaysInMonth(date.getFullYear(), date.getMonth()))
        );
        return date;
    }
}

function addYearsToDate(years, date) {
    if (years !== 0) {
        let year = date.getFullYear();
        year += years;
        date.setFullYear(year);
    }
}

function copyDate(date) {
    if (!date) {
        return null;
    }
    let newDate = new Date();
    newDate.setTime(date.getTime());
    return newDate;
}

function numberOfDaysBetween(start, finish) {
      if (!start || !finish) {
        return 0;
      }

      // Convert the dates to the same time
      start = copyDate(start);
      [start resetTime];
      finish = copyDate(finish);
      [finish resetTime]
    
      let aTime = [start time];
      let bTime = [finish time];

      return (aTime - bTime) / (24 * 60 * 60 * 1000);
}

/**
 * Returns the date that occurs first
 *
 * @param date1
 * @param date2
 * @return Date
 */
function getEarliest(date1, date2) {
    if (getDaysBetween(date1, date2) < 0) {
      return date2;
    }
    return date1;
}
  
  /**
   * Returns the date that occurs last
   *
   * @param date1
   * @param date2
   * @return Date
   */
function getLatest(date1, date2) {
    if (getDaysBetween(date1, date2) > 0) {
      return date2;
    }
    return date1;
}

/**
 * Check if two dates represent the same date of the same year, even if they have different times.
 *
 * @param date0 a date
 * @param date1 a second date
 * @return true if the dates are the same
 */
function isSameDate(date0, date1) {
    if (!date0 || !date1 ) {
      return false;
    }
    return (
      date0.getFullYear() === date1.getFullYear() &&
      date0.getMonth() === date1.getMonth() &&
      date0.getDate() === date1.getDate()
    );
}
  
function isSameMonthAndYear(date0, date1) {
    if (!date0  || !date1 ) {
      return false;
    }
    return (
      date0.getFullYear() === date1.getFullYear() &&
      date0.getMonth() === date1.getMonth()
    );
}
  
  /**
   * Sets a date object to be at the beginning of the month and no time specified.
   *
   * @param date the date
   */
function setToFirstDayOfMonth(date) {
    [date resetTime];
    date.setDate(1);
}
  
  /**
   * Is a day in the week a weekend?
   *
   * @param dayOfWeek day of week
   * @return is the day of week a weekend?
   */

isWeekend(dayOfWeek) {
    return dayOfWeek === 6 || dayOfWeek === 0;
}
  
function isToday(date) {
    const today = new Date();
    return (
      today.getMonth() === date.getMonth() &&
      today.getFullYear() === date.getFullYear() &&
      today.getDate() === date.getDate()
    );
}

function isValidDate(date) {
    return !isNaN(date.getTime());
};
 