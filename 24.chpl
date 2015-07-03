use Sort;

proc toInt(arr) {
  var n = 0;
  for i in arr.domain {
    n = n * 10 + arr[i];
  }
  return n;
}

inline proc swap(arr, i, j) {
  var c = arr[i];
  arr[i] = arr[j];
  arr[j] = c;
}

// dijkstra's lexical ordering algo
proc getNext(arr) {
  var N = arr.size;

  var i = N - 1;
  while (arr[i-1] >= arr[i]) {
    i -= 1;
  }

  var j = N;
  while (arr[j-1] <= arr[i-1]) {
    j -= 1;
  }

  swap(arr, i-1, j-1);

  i += 1;
  j = N;
  while (i < j) {
    swap(arr, i-1, j-1);
    i += 1;
    j -= 1;
  }
}

var arr: [0..9] int = [0,1,2,3,4,5,6,7,8,9];
for i in 1..1000000-1 {
  getNext(arr);
}
writeln(toInt(arr));
