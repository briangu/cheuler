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

  iter primes(max: int, param tag: iterKind) where tag == iterKind.standalone {
    forall i in 1..max {
      if (isPrime(i)) {
        yield i;
      }
    }
  }

  iter primes(max: int) {
    for i in 1..max {
      if (isPrime(i)) {
        yield i;
      }
    }
  }

  proc nextPrime(start: int, end: int, ref p: int): bool {
    var i = start + 1;
    while (i <= end) {
      if (isPrime(i)) {
        p = i;
        return true;
      }
      i += 1;
    }
    return false;
  }

  proc prevPrime(start: int, ref p: int): bool {
    var i = start - 1;
    while (i > 1) {
      if (isPrime(i)) {
        p = i;
        return true;
      }
      i -= 1;
    }
    return false;
  }
}
