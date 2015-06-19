
config const N = 1000000;

iter collatz(start: int) {
  var n = start;
  while (n != 1) {
    yield n;
    if (n % 2 == 0) {
      n /= 2;
    } else {
      n = 3 * n + 1;
    }
  }
}

iter collatzCounts(n: int) {
  for i in 1..N {
    var x = 0;
    for c in collatz(i) {
      x += 1;
    }
    yield(i, x);
  }
}

var maxCount = 0;
var maxX = 0;

for (x, count) in collatzCounts(N) {
  if (count > maxCount) {
    maxCount = count;
    maxX = x;
  }
}

writeln("longest collatz sequence is for ", maxX, " with length ", maxCount);