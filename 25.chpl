config const N = 3;

proc prettyPrint(a) {
  var startIdx = a.size;
  for j in a.domain by -1 {
    if (a[j] != 0) then break;
    startIdx -= 1;
  }
  for j in 1..startIdx by -1 {
    write(a[j]);
  }
  writeln();
}

proc add(a, b, c): bool {
  var carry = 0;
  var sum: int;
  for i in a.domain {
    sum = carry + a[i] + b[i];
    c[i] = sum % 10;
    carry = sum / 10;
  }
  return (carry > 0);
}

iter fib() {
  var a: [1..N] int;
  var b: [1..N] int;
  var c: [1..N] int;
  a[1] = 1;
  b[1] = 1;

  while (true) {
    var overflow = add(a, b, c);
    if (overflow) {
      writeln("overflow!");
      break;
    }
    yield c;
    if (c[N] != 0) {
      break;
    }
    a = b;
    b = c;
  }
}

var idx = 2; // offset for the first two 1's
for i in fib() {
  idx += 1;
}
writeln(idx);
