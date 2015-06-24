/*

You are given the following information, but you may prefer to do some research for yourself.

1 Jan 1900 was a Monday.

Thirty days has September,
April, June and November.

All the rest have thirty-one,

Saving February alone,
Which has twenty-eight, rain or shine.
And on leap years, twenty-nine.

A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.

How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?

*/

config const startYYYY = 1901;
config const startMM = 1;
config const startDD = 1;

config const stopYYYY = 2000;
config const stopMM = 12;
config const stopDD = 31;

var DOW_SUNDAY    = 0;
var DOW_MONDAY    = 1;
var DOW_TUESDAY   = 2;
var DOW_WEDNESDAY = 3;
var DOW_THURSDAY  = 4;
var DOW_FRIDAY    = 5;
var DOW_SATURDAY  = 6;

var initYYYY = 1900;
var initMM = 1;
var initDD = 1;
var initDOW = DOW_MONDAY; 

proc monthLength(yyyy: int, mm: int): int {
  if (mm == 4 || mm == 6 || mm == 9 || mm == 11) {
    return 30;
  } else if (mm == 2) {
    if (yyyy % 100 == 0) {
      if (yyyy % 400 == 0) {
        return 29;
      } else {
        return 28;
      }
    } else if (yyyy % 4 == 0) {
      return 29;
    }
    return 28;
  }
  return 31;
}

iter walkDays(startYYYY: int, startMM: int, startDD: int, startDOW: int, stopYYYY: int, stopMM: int, stopDD: int) {
  var yyyy = startYYYY;
  var mm = startMM;
  var dd = startDD;
  var dow = startDOW;

  while ((yyyy < stopYYYY) || (yyyy == stopYYYY && mm < stopMM) || (yyyy == stopYYYY && mm == stopMM && dd < stopDD)) {
    dow = (dow + 1) % 7;
    dd += 1;
    if (dd > monthLength(yyyy, mm)) {
      if (mm == 12) {
        yyyy += 1;
        mm = 1;
      } else {
        mm += 1;
      }
      dd = 1;
    }
    yield(yyyy, mm, dd, dow);
  }
}

// find the DOW for the start date
var startDOW: int;

for (yyyy, mm, dd, dow) in walkDays(initYYYY, initMM, initDD, initDOW, startYYYY, startMM, startDD) {
  startDOW = dow;
}

var firstSundays = 0;

for (yyyy, mm, dd, dow) in walkDays(startYYYY, startMM, startDD, startDOW, stopYYYY, stopMM, stopDD) {
  if (dd == 1 && dow == 0) {
    firstSundays += 1;
  }
}

writeln(firstSundays);
