use Divisors;

var abundant: domain(int);
var sum: atomic int;

forall i in 12..28123 {
  var divArr = [j in divisors(i)] j;
  var divSum = + reduce divArr;
  if (divSum > i) {
    abundant.add(i);
  }
}

var sortedAbundant = abundant.sorted();

forall i in 1..28123 {
  for a in sortedAbundant {
    if (a >= i) {
      sum.add(i);
      break;
    }

    if (abundant.member(i - a)) {
      break;
    }
  }
}

writeln(sum);