use Random;

var seed = 17;
var rand = new RandomStream(seed);

proc getNext(): real {
  return rand.getNext();
}

proc _max(m): real {
  if (m.domain.low > m.domain.high) then return min(real);
  return max(m(m.domain.low), _max(m[m.domain.low+1..]));
}

var m: atomic real;

// would like to have a way to get the max out of this forall w/o explicit atomic logic
forall 1..100 {
  var n = getNext();
  while (n > m.read()) {
    m.compareExchange(m.read(), n);
  }
}
writeln("max value is: ", m.read());

// works but not parallel and allocates memory
rand = new RandomStream(seed);
var res = [i in 1..100] getNext(); // bug: can't use array expression directly in _max()
writeln("max value is: ", _max(res));
