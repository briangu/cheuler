var ones: [1..100] int = 1;
var r = + scan ones;
var squares = r * r;

var sumOfSquareOfRange = + reduce squares;
var sumOfRange = + reduce r;
var squareOfSumOfRange = sumOfRange ** 2;

writeln(squareOfSumOfRange, " ", sumOfSquareOfRange, " ", squareOfSumOfRange - sumOfSquareOfRange);
