use Primes;

config const N = 2000000;

writeln(+ reduce [i in primes(N)] i);
