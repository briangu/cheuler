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
var siblingHead: Node;
var siblingPointer: Node;

proc loadData() {
  var f = open(Filename, iomode.r);
  var r = f.reader();

  // simplify the reading code by knowing the height in advance
  var M = r.read(int); 

  var v: int;

  // simplify by reading the root node seperately
  r.read(v);
  root = new Node(v);
  lastRowHead = root;
  lastRowPointer = lastRowHead;

  var n: Node;

  for j in 2..M {
    r.read(v);

    n = new Node(v, nil, lastRowPointer);
    lastRowPointer.leftChild = n;
    siblingHead = n;
    siblingPointer = siblingHead;

    for i in 2..j {
      r.read(v);
      n = new Node(v, lastRowPointer, lastRowPointer.sibling);
      lastRowPointer.rightChild = n;
      if (lastRowPointer.sibling != nil) {
        lastRowPointer.sibling.leftChild = n;
      }
      siblingPointer.sibling = n;

      siblingPointer = siblingPointer.sibling;
      lastRowPointer = lastRowPointer.sibling;
    }

    lastRowHead = siblingHead;
    lastRowPointer = lastRowHead;

    computeRowCounts(lastRowHead);
  }

  f.close();
}

proc reverseBruteForceMaxTreePath(n: Node, ref maxSum: int, sum: int = 0): int {
  if (n == nil) {
    if (sum > maxSum) {
      maxSum = sum;
    }
    return maxSum;
  }

  if (n.count != -1) {
    reverseBruteForceMaxTreePath(nil, maxSum, sum + n.count);
  } else {
    reverseBruteForceMaxTreePath(n.leftParent, maxSum, sum + n.value);
    reverseBruteForceMaxTreePath(n.rightParent, maxSum, sum + n.value);
  }

  return maxSum;
}

proc greedyRowScan(head: Node, ref maxSum: int) {
  var n = head;
  while (n != nil) {
    var altMaxSum = 0;
    var sum = reverseBruteForceMaxTreePath(n, altMaxSum);
    if (sum > maxSum) {
      maxSum = sum;
    }
    n = n.sibling;
  }
}

proc computeRowCounts(head: Node) {
  var n = head;
  while (n != nil) {
    if (n.count == -1) {
      var altMaxSum = 0;
      n.count = reverseBruteForceMaxTreePath(n, altMaxSum);
    }
    n = n.sibling;
  }
}

loadData();

var maxSum: int = 0;
greedyRowScan(lastRowHead, maxSum);
writeln(maxSum);
