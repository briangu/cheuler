/*

A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.

Find the largest palindrome made from the product of two 3-digit numbers.

*/

proc isPalindrome(n: int): bool {
  var k: int = 0;
  var j = n;
  while (j > 0) {
    var r = j % 10;
    if (r == 0 && k == 0) {
      return false; // ignore cases when the palindrome begins and ends with a 0
    }
    k = (k * 10) + r;
    j /= 10;
    if (j == k) {
      return true;
    } else if (k > j) {
      break; // passed the middle of n
    }
  }
  return false;
}

iter palindromes() {
  for (i,j) in {100..999, 100..999} {
    var n = i * j;
    if (isPalindrome(n)) {
      yield n;
    }
  }
}

var bestPalindrome = 0;
for j in palindromes() {
  if (j > bestPalindrome) {
    bestPalindrome = j;
  }
}
writeln(bestPalindrome);