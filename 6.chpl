// https://projecteuler.net/problem=6

iter squareOfRange(d) {
  for i in d {
    yield i * i;
  }
}

var sumOfSquareOfRange = 0;
for i in squareOfRange({1..100}) {
  sumOfSquareOfRange += i;
}

var sumOfRange = 0;
for i in {1..100} {
  sumOfRange += i;
}
var squareOfSumOfRange = sumOfRange ** 2;

writeln(squareOfSumOfRange, " ", sumOfSquareOfRange, " ", squareOfSumOfRange - sumOfSquareOfRange);
