config const N = 15;

var digits: [1..1000] int;
digits[1] = 1;

var maxPos = 1;

for i in 1..N {
  var carry = 0;
  var pos = 1;
  while (pos <= maxPos) {
    var p = carry + digits[pos] * 2;
    digits[pos] = p % 10;
    carry = p / 10;
    pos += 1;
  }
  while (carry > 0) {
    digits[pos] = carry % 10;
    carry /= 10;
    maxPos = pos;
    pos += 1;
  }
}

var sum = 0;
for i in 1..maxPos by -1 {
  write(digits[i]);
  sum += digits[i];
}
writeln();
writeln(sum);

