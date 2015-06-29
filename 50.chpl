use Primes;

config const N = 100;

proc consecutivePrimeCount(parr, targetPrime, parrSum): int {
  var maxSum = parrSum;
  if (maxSum < targetPrime) {
    return 0;
  } else if (maxSum == targetPrime) {
    return parr.size;
  }  

  var maxCount = 0;
  var w = 1;

  while (w <= (parr.size - 1)) {
    var windowSize = parr.size - w;

    maxSum -= parr[windowSize + 1];

    var preIdx = 0;
    var postIdx = windowSize;
    var sum = maxSum;
    
    while (sum < targetPrime) {
      preIdx += 1;
      postIdx += 1;

      sum -= parr[preIdx];
      sum += parr[postIdx];
    }

    if (sum == targetPrime) {
      maxCount = windowSize;
      break;
    }

    w += 1;
  }

  return maxCount;
}

var maxCount = 0;
var maxPrime: int;
var parr = [i in primes(N-1)] i;
var maxSum = + reduce parr;

for i in 1..parr.size by -1 {
  maxSum -= parr[i];
  var count = consecutivePrimeCount(parr[1..i-1], parr[i], maxSum);
  if (count > maxCount) {
    maxCount = count;
    maxPrime = parr[i];
  }
}

writeln(maxPrime);
