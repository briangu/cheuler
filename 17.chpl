config const N = 5;

var numberDom: domain(int);
var numberWordMap: [numberDom] string;

numberWordMap[0] = "";
numberWordMap[1] = "one";
numberWordMap[2] = "two";
numberWordMap[3] = "three";
numberWordMap[4] = "four";
numberWordMap[5] = "five";
numberWordMap[6] = "six";
numberWordMap[7] = "seven";
numberWordMap[8] = "eight";
numberWordMap[9] = "nine";
numberWordMap[10] = "ten";
numberWordMap[11] = "eleven";
numberWordMap[12] = "twelve";
numberWordMap[13] = "thirteen";
numberWordMap[14] = "fourteen";
numberWordMap[15] = "fifteen";
numberWordMap[16] = "sixteen";
numberWordMap[17] = "seventeen";
numberWordMap[18] = "eighteen";
numberWordMap[19] = "nineteen";
numberWordMap[20] = "twenty";
numberWordMap[30] = "thirty";
numberWordMap[40] = "forty";
numberWordMap[50] = "fifty";
numberWordMap[60] = "sixty";
numberWordMap[70] = "seventy";
numberWordMap[80] = "eighty";
numberWordMap[90] = "ninety";
numberWordMap[1000] = "one thousand";

proc nameFromNumber(n: int): string {
  if (numberDom.member(n)) {
    return numberWordMap(n);
  }

  var tens = if (n >= 100) then nameFromNumber(n % 100) else "";
  var hundreds = nameFromNumber((n / 100) % 10);

  var s = "";

  if (hundreds.length > 0) {
    if ((n % 100) > 0) {
      s += hundreds + " hundred and ";
    } else {
      s += hundreds + " hundred ";
    }
  }

  if (tens.length == 0) {
    tens = nameFromNumber(((n / 10) % 10) * 10);
    var ones = nameFromNumber(n % 10);
    if (ones.length > 0) {
      s += tens + " ";
    } else {
      s += tens;
    }
    s += ones;
  } else {
    s += tens;
  }

  return s;
}

proc nameLength(name: string): int {
  var l = 0;
  for i in 1..name.length {
    if (name.substring(i) != " ") {
      l += 1;
    }
  }
  return l;
}

var sum = 0;
for i in 1..N {
  var name = nameFromNumber(i);
  var length = nameLength(name);
  sum += length;
}
writeln(sum);
