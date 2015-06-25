/*
If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
Find the sum of all the multiples of 3 or 5 below 1000.
*/

config const N = 10;

iter multiples(limit: int) {
  for i in 3..limit {
    if (i % 3 == 0 || i % 5 == 0) {
      yield i;
    }
  }  
}

writeln(+ reduce [i in multiples(N-1)]);

