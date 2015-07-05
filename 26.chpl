
config const Precision = 5000;
config const N = 1000;

proc prettyPrint(a) {
  var startIdx = a.size;
  for j in a.domain by -1 {
    if (a[j] != 0) then break;
    startIdx -= 1;
  }
  write("0.");
  for j in 0..startIdx-1 {
    write(a[j]);
  }
  writeln();
}

iter division(n: int) {
  var digits: [0..Precision] int;

  for v in 2..n {
    digits = 0;
    var m = digits.domain.low;
    var s = 10;

    while (m <= digits.domain.high && (s > 0)) {
      if (s < v) {
        s *= 10;
      } else {
        digits[m] = floor(s / v): int;
        s = (s % v) * 10;
      }
      m += 1;
    }

    var cycleLength = 1;
    var cycleFound = false;
    var cp = 0;
    var cpOffset = 0;
    const maxM = m - 1;

    if (maxM == digits.domain.high) {
      while (!cycleFound && (cpOffset < digits.domain.high)) {
        cycleLength = 1;
        m = cpOffset;
        cp = 0;
        while (m <= maxM) {
          if (digits[cp + cpOffset] != digits[m]) {
            cycleLength += 1;
            cycleFound = false;
            cp = 0;
          } else {
            cp = (cp + 1) % cycleLength;
            if (cp == 0) {
              cycleFound = true;
            }
          }

          m += 1;
        }
        cpOffset += 1;
      }
    }

    /*write((v, cycleFound, cycleLength, cpOffset, digits), " ");*/
    /*prettyPrint(digits);*/

    yield (v, cycleFound, cycleLength, digits);
  }
}

var maxCycleLength = 0;
var maxDivisor: int;
var maxDigits: [0..Precision] int;
for (divisor, cycleFound, cycleLength, d) in division(N) {
  if (cycleFound && (cycleLength > maxCycleLength)) {
    maxCycleLength = cycleLength;
    maxDivisor = divisor;
    maxDigits = d;
  }
}
writeln((maxDivisor, maxCycleLength));
prettyPrint(maxDigits);
