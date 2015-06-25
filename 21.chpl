config const N = 10000;

iter divisors(n: int) {
  for i in 1..floor(n/2):int {
    if (n % i == 0) {
      yield i;
    }
  }
}

iter amicableNumbers() {
  var a = 0;
  while (true) {
    a += 1;
    // d(a) = b
    var b = + reduce [j in divisors(a)] j;
    if (a == b) {
      continue;
    }
    // d(b) ?= a
    var aPrime = + reduce [j in divisors(b)] j;
    if (aPrime == a) {
      yield(a); // only return a since we'll get to b later
    }
  }
}

var sum = 0;
for a in amicableNumbers() {
  if (a > N) {
    break;
  }
  sum += a;
}
writeln(sum);
