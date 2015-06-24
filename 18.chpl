config const Filename = "18.dat";

class Node {
  var value: int;
  var leftParent: Node;
  var rightParent: Node;
  var leftChild: Node;
  var rightChild: Node;
  var sibling: Node;
  var count = -1;
}

var root: Node;
var lastRowHead: Node;
var lastRowPointer: Node;
var newRowHead: Node;
var newRowPointer: Node;

proc loadData(ref maxSum: int) {
  var f = open(Filename, iomode.r);
  var r = f.reader();

  // simplify the reading code by knowing the height in advance
  var M = r.read(int); 

  var v: int;

  // simplify by reading the root node seperately
  r.read(v);
  root = new Node(v);
  lastRowHead = root;

  var n: Node;

  for j in 2..M {
    lastRowPointer = lastRowHead;

    r.read(v);
    n = new Node(v, nil, lastRowPointer);
    lastRowPointer.leftChild = n;
    newRowHead = n;
    newRowPointer = newRowHead;

    for i in 2..j {
      r.read(v);
      n = new Node(v, lastRowPointer, lastRowPointer.sibling);

      lastRowPointer.rightChild = n;
      if (lastRowPointer.sibling != nil) {
        lastRowPointer.sibling.leftChild = n;
      }

      newRowPointer.sibling = n;
      newRowPointer = newRowPointer.sibling;

      lastRowPointer = lastRowPointer.sibling;
    }

    lastRowHead = newRowHead;

    computeRowCounts(lastRowHead, maxSum);
  }

  f.close();
}

proc reverseBruteForceMaxTreePath(n: Node, ref maxSum: int, sum: int = 0) {
  if (n == nil) {
    if (sum > maxSum) {
      maxSum = sum;
    }
    return;
  }

  if (n.count != -1) {
    reverseBruteForceMaxTreePath(nil, maxSum, sum + n.count);
  } else {
    reverseBruteForceMaxTreePath(n.leftParent, maxSum, sum + n.value);
    reverseBruteForceMaxTreePath(n.rightParent, maxSum, sum + n.value);
  }
}

proc computeRowCounts(head: Node, ref maxSum: int) {
  var n = head;
  while (n != nil) {
    var altMaxSum = 0;
    reverseBruteForceMaxTreePath(n, altMaxSum);
    n.count = altMaxSum;
    if (altMaxSum > maxSum) {
      maxSum = altMaxSum;
    }
    n = n.sibling;
  }
}

var maxSum: int = 0;
loadData(maxSum);
writeln(maxSum);
