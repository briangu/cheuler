/*
Each new term in the Fibonacci sequence is generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:

1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms.
*/

config const max = 100;

iter fib(max: int) {
  var a = 0;
  var b = 1;
  var c = 1;
  while (c <= max) {
    yield c;
    a = b;
    b = c;
    c = a + b;
  }
}

var sum = 0;
for i in fib(max) {
  if (i % 2 == 0) {
    sum += i;
  }
}
writeln(sum);
