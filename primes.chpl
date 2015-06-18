module Primes {
  
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
}