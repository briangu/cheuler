/*
The prime factors of 13195 are 5, 7, 13 and 29.

What is the largest prime factor of the number 600851475143 ?
*/

config const N = 13195;

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

iter primes(max: int) {
  var i = 1;
  while (i <= max) {
    if (isPrime(i)) {
      yield i;
    }
    i += 1;
  }
}

var n = N;
var k = 1;
var largestPrime: int = -1;

for p in primes(N) {
  if (n % p == 0) {
    writeln(p);
    largestPrime = p;
    k *= largestPrime;
    if (k == N) {
      break;
    }
    n /= p;
  }
}

if (largestPrime > 0) {
  writeln("largest prime factor of ", N, " is ", largestPrime);
}
