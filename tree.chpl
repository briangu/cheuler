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

  proc insertNode(root: Node, node: Node) {
    if (root == nil) {
      return;
    }
    if (node.value > root.value) {
      if (root.right) {
        insertNode(root.right, node);
      } else {
        root.right = node;
      }
    } else if (node.value < root.value) {
      if (root.left) {
        insertNode(root.left, node);
      } else {
        root.left = node;
      }
    }
  }

  proc generateRandomTree(n: int): Node {
    var root = new Node(nextRandomInt(n));
    for i in 2..n {
      insertNode(root, new Node(nextRandomInt(n)));
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

  // TODO: rewrite to use minimal stacks
  proc balanceTree(root) {

  }

  proc buildValueStack(root, stack) {
    if (root == nil) then return;
    buildValueStack(root.right, stack);
    stack.push(root);
    buildValueStack(root.left, stack);
  }

  // TODO: rewrite to use minimal stacks
  iter enumerateInOrder(root) {
    var stack = new Stack(root.type);
    buildValueStack(root, stack);

    while (!stack.isEmpty) {
      yield stack.pop().value;
    }
  }
}
