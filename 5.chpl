/*
2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.

What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
*/

proc isEvenlyDivisible(n: int, d: int): bool {
  return n % d == 0;
}

proc isEvenlyDivisibleByRange(n: int, d): bool {
  for i in d {
    if (!isEvenlyDivisible(n, i)) {
      return false;
    }
  }
  return true;
}

var i = 1;

while (true) {
  if (isEvenlyDivisibleByRange(i, {2..20})) {
    writeln(i);
    break;
  }
  i += 1;
}
