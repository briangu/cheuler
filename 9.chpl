// https://projecteuler.net/problem=9

config const N = 1000;

for a in 1..N-2 {
  for b in a+1..N-1 {
    for c in b+1..N {
      if (((a**2 + b**2) == c**2) && (a + b + c == N)) {
        writeln(a * b * c);
      }
    }
  }
}

