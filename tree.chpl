// TODO: most of the code in this module leaks memory
module Tree {

  use Random, Stack;

  var seed = 17;
  var rand = new RandomStream(seed);

  class Node {
    var value: int;
    var left: Node;
    var right: Node;
  }

  proc nextRandomInt(n: int = max(int(64))): int {
    return (rand.getNext() * n): int;
  }

  proc prettyPrint(node: Node, depth: int = 0, prefix: string = "") {
    if (node == nil) {
      return;
    }

    prettyPrint(node.left, depth + 1, node.value + " L ");

    for i in 1..depth {
      write("\t");
    }
    writeln(prefix, node.value);

    prettyPrint(node.right, depth + 1, node.value + " R ");
  }

  proc insertNode(root: Node, node: Node): bool {
    if (root == nil || node == nil) {
      return false;
    }
    var added = false;
    if (node.value > root.value) {
      if (root.right) {
        added = insertNode(root.right, node);
      } else {
        root.right = node;
        added = true;
      }
    } else if (node.value < root.value) {
      if (root.left) {
        added = insertNode(root.left, node);
      } else {
        root.left = node;
        added = true;
      }
    }
    return added;
  }

  proc generateRandomTree(n: int, maxValue: int = n): Node {
    var root = new Node(nextRandomInt(n));
    var count = 1;
    while (count < n) {
      var added = insertNode(root, new Node(nextRandomInt(maxValue)));
      if (added) {
        count += 1;
      }
    }
    return root;
  }

  // https://en.wikipedia.org/wiki/Tree_rotation
  // move root to root.left's right
  proc rotateRight(root: Node): Node {
    if (root.left == nil) then return root;
    var left = root.left;
    root.left = nil;
    insertNode(root, left.right);
    left.right = root;
    return left;
  }

  // move root to root.right's left
  proc rotateLeft(root: Node): Node {
    if (root.right == nil) then return root;
    var right = root.right;
    root.right = nil;
    insertNode(root, right.left);
    right.left = root;
    return right;
  }

  proc balanceTree(ref root) {
    proc insertIntoBalancedTreeInternal(root, nodes) {
      if (nodes.size == 0) then return;

      var midIdx = floor(nodes.size / 2): int + nodes.domain.low;
      var node = nodes[midIdx];
      node.left = nil;
      node.right = nil;
      insertNode(root, node);

      insertIntoBalancedTreeInternal(node, nodes[..midIdx-1]);
      insertIntoBalancedTreeInternal(node, nodes[midIdx+1..]);
    }

    var flatTree = [node in enumerateInAscendingOrder(root)] node;

    var midIdx = floor(flatTree.size / 2): int;
    root = flatTree[midIdx];
    root.left = nil;
    root.right = nil;

    insertIntoBalancedTreeInternal(root, flatTree[..midIdx-1]);
    insertIntoBalancedTreeInternal(root, flatTree[midIdx+1..]);
  }

  proc treeHeight(root, height: int = 0): int {
    if (root == nil) then return height;
    return max(treeHeight(root.left, height + 1), treeHeight(root.right, height + 1));
  }

  proc isBalancedTree(root): bool {
    return (root == nil) ||
           (root.left == nil && root.right == nil) ||
           (isBalancedTree(root.left) &&
            isBalancedTree(root.right) &&
            (abs(treeHeight(root.left) - treeHeight(root.right)) <= 1));
  }

  iter enumerateInDescendingOrder(root) {
    var stack = new Stack(root.type);
    var node = root;

    while (!stack.isEmpty || node != nil) {
      while (node != nil) {
        stack.push(node);
        node = node.right;
      }
      node = stack.pop();
      yield node;
      node = node.left;
    }

    delete stack;
  }

  iter enumerateInAscendingOrder(root) {
    var stack = new Stack(root.type);
    var node = root;

    while (!stack.isEmpty || node != nil) {
      while (node != nil) {
        stack.push(node);
        node = node.left;
      }
      node = stack.pop();
      yield node;
      node = node.right;
    }

    delete stack;
  }
}
