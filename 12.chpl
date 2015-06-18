config const N = 1;
config const K = 5;

var dom: domain(int);
var cache: [dom] int;
cache[0] = 0;
cache[1] = 1;

proc sum(n: int) {
  var j = n;
  var s = 0;
  while (j > 0) {
    if (dom.member(j)) {
      s += cache[j];
      break;
    }
    s += j;
    j -= 1;
  }
  cache[n] = s;
  return s;
}

iter divisible(n: int) {
  var s = sum(n);
  var max = 2;
  var i = 1;
  while (i < max) {
    if (s % i == 0) {
      var x = s / i;
      if (i == x) {
        yield i;
        break;
      } else if (i > x) {
        break;
      } 
      yield i;
      yield x;
      if (x > max) {
        max = x;
      }
    }
    i += 1;
  }
}

proc divisibleCount(n: int) {
  var s = sum(n);
  var max = 2;
  var i = 1;
  var count = 0;
  while (i < max) {
    if (s % i == 0) {
      var x = s / i;
      if (i == x) {
        count += 1;
        break;
      } else if (i > x) {
        break;
      } 
      count += 2;
      if (x > max) {
        max = x;
      }
    }
    i += 1;
  }
  return count;
}

var i = N;
while (divisibleCount(i) < K) {
  i += 1;
}

writeln(sum(i));
