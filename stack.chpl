module Stack {

  class StackNode {
    type itemType;
    var item: itemType;
    var next: StackNode(itemType);
  }

  class Stack {
    type itemType;
    var root: StackNode(itemType);

    proc push(x: itemType) {
      root = new StackNode(itemType, x, root);
    }

    proc pop(): itemType {
      if isEmpty then halt("attempt to pop an item off an empty stack");
      var node = root;
      root = root.next;
      return node.item;
    }

    proc size: int {
      var sum = 0;
      var node = root;
      while (node != nil) {
        sum += 1;
        node = node.next;
      }
      return sum;
    }

    proc isEmpty return root == nil;
  }
}
