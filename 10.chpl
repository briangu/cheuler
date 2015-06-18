/*
The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

Find the sum of all the primes below two million.
*/

use Primes;

config const N = 2000000;

var sum = 0;
for p in primes(N) {
  sum += p;
}
writeln(sum);
