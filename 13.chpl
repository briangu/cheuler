/*

Work out the first ten digits of the sum of the following one-hundred Digits-digit numbers.

*/

config const Digits = 50;
config const Rows = 100;
config const Filename = "13.dat";

var data: [1..Digits, 1..Rows] int;
var sum: [1..2*Digits] int;

proc loadData() {
  var f = open(Filename, iomode.r);

  var j = 1;
  for line in f.lines() {
    for i in 1..Digits {
      data[i,j] = line.substring(i): int;
    }
    j += 1;
  }

  f.close();
}

proc showSum() {
  var i = sum.domain.high;
  var found = false;
  while (i >= 1) {
    if (!found) {
      if (sum[i] != 0) {
        found = true;
      }
    } 
    if (found) {
      write(sum[i]);
    }
    i -= 1;
  }
  writeln();
}

loadData();

var accum = 0;
var carry = 0;

var z = 1;
for i in 1..Digits by -1 {
  accum = carry;

  for j in 1..Rows {
    accum += data[i, j];
  }

  sum[z] = accum % 10;
  z += 1;
  carry = accum / 10;
}

var i = Digits + 1;
while (carry > 0) {
  sum[i] = carry % 10;
  carry /= 10;
  i += 1;
}

showSum();
