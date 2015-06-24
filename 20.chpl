config const N = 10;

var digits: [1..1000] int;

proc sum(d: [?D] int): int {
  return + reduce d;
}

digits[1] = 1;

for x in 2..N {
  var carry = 0;
  for i in digits.domain {
    var v = digits[i] * x + carry;
    carry = v / 10;
    digits[i] = v % 10;
  } 
}

writeln(sum(digits));