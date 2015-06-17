/*
If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
Find the sum of all the multiples of 3 or 5 below 1000.
*/

config const n = 10;

iter multiples(limit: int) {
  for i in 3..limit {
    if (i % 3 == 0 || i % 5 == 0) {
      yield i;
    }
  }  
}

var sum = 0;
for x in multiples(n-1) {
  sum += x;
}
writeln(sum);

