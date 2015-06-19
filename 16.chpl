config const N = 15;

var digits: [1..1000] int;
digits[1] = 1;

var maxPos = 1;

for i in 1..N {
  var carry = 0;
  for d in digits.domain {
    var p = carry + digits[d] * 2;
    digits[d] = p % 10;
    carry = p / 10;
  }
}

var sum = 0;
for i in digits.domain {
  sum += digits[i];
}
writeln(sum);

