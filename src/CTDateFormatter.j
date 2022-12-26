#import "CTObject.j"
#import "CTDate.j"

/**
  Template:

  M - numeric month
  MM - 2-digit month
  MMM - short month
  MMMM - long month

  YYYY - numeric year
  YY - 2-digit year

  d - numeric day
  dd - 2-digit day
  
  D or DD - narrow day of week
  DDD - short day of week
  DDDD - long day of week

  h - numeric hour
  hh - 2-digit hour
  
  m - numeric minute
  mm - 2-digit minute

  s - numeric second
  ss = 2-digit second

**/


function getFormattedMonth(date, locale, pattern) {
    let opt = "numeric"
    switch(pattern) {
        case "MM" : {
            opt = "2-digit";
        }break;
        case "MMM" : {
            opt = "short";
        }break;
        case "MMMM" : {
            opt = "long"
        }break;
    }
    return date.toLocaleString(locale,  {
        month: opt 
    });
}

function getFormattedWeekDay(date, locale, pattern) {
    let opt = "narrow";
    if(pattern === "DDD") {
        opt = "short";
    }
    else if(pattern === "DDDD") {
        opt = "long";
    }
    return date.toLocaleString(locale, {
        weekday: opt 
    });
}

function getFormattedNumber(date, locale, pattern) {
    let attr ;
    if(['YY', "YYYY"].includes(pattern)) {
        attr = "year";
    }
    else if(['d', 'dd'].includes(pattern)) {
        attr = "day";
    }
    else if(["h", "hh"].includes(pattern)) {
        attr = "hour";
    }
    else if(["m", "mm"].includes(pattern)) {
        attr = "minute";
    }
    else if(["s", "ss"].includes(pattern)) {
        attr = "second";
    }

    const options = {};
    options[attr] = pattern.length === 2 ? "2-digit" : "numeric";
    return date.toLocaleString(locale, options);
}

function formatToken(date, locale, token) {
    const tok = token[0];
    switch(tok) {
        case 'M': {
            return getFormattedMonth(date, locale, token);
        }
        case 'D' : {
            return getFormattedWeekDay(date, locale, token);
        }
    }
    return getFormattedNumber(date, locale, token);
}


@implementation CTDateFormatter : CTObject
 

+(String) formatDate:(CTDate)date locale:(String)locale usingTemplate:(String)template {
       const reservedChars = ['M', "d", "D", "Y", "m", "h", "s"];
       const tokens = [];
       let token = "";
       let insideToken = true; 
       for(const ch of template) {
          if(reservedChars.includes(ch)) {
             if(insideToken) {
                token += ch;
             }
             else {
                tokens.push(token);
                token = ch; 
             }
             insideToken = true; 
          }          
          if(!reservedChars.includes(ch)) {
              if(insideToken) {
                tokens.push(token);
                token = ch;
              }
              else {
                token += ch;
              }
              insideToken = false; 
          }
       }
       tokens.push(token);
       const formatted = [];
       for(const tok of tokens) {
         if(tok.length > 0) {
            if(reservedChars.includes(tok[0])) {
                formatted.push(formatToken(date, locale, tok));
            }
            else {
                formatted.push(tok);
            }
         }
       }
       return formatted.join("");
}

+(String) formatDate:(CTDate)date usingTemplate:(String)template {
    return [CTDateFormatter formatDate:date locale:"default" usingTemplate:template];
}
 


@end