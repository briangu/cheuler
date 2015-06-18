// find the 10001'th prime

proc isPrime(n: int) {
  if (n <= 3) {
    return n > 1;
  } else if (n % 2 == 0 || n % 3 == 0) {
    return false;
  }

  var sqrtN = floor(sqrt(n)): int;
  for i in 5..sqrtN by 6 {
    if (n % i == 0 || n % (i + 2) == 0) {
      return false;
    }
  }

  return true;
}

var primeIdx = 0;
var lastPrime: int;
var i = 0;
while (primeIdx < 10001) {
  if (isPrime(i)) {
    primeIdx += 1;
    lastPrime = i;
  }
  i += 1;
}

writeln(lastPrime)