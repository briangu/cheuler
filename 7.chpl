// find the 10001'th prime

use Primes;

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