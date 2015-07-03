module Divisors {

  iter divisors(n: int, param tag: iterKind) where tag == iterKind.standalone {
    forall i in 1..floor(n/2):int {
      if (n % i == 0) {
        yield i;
      }
    }
  }

  iter divisors(n: int) {
    for i in 1..floor(n/2):int {
      if (n % i == 0) {
        yield i;
      }
    }
  }
}