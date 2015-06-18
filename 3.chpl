/*
The prime factors of 13195 are 5, 7, 13 and 29.

What is the largest prime factor of the number 600851475143 ?
*/

use Primes;

config const N = 13195;

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
