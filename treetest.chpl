use Tree;

config const N = 10;

var root = generateRandomTree(N);
prettyPrint(root);
writeln("---------------------------");

root = rotateRight(root);
prettyPrint(root);
writeln("---------------------------");

root = rotateLeft(root);
prettyPrint(root);
writeln("---------------------------");

writeln([node in enumerateInDescendingOrder(root)] node.value);
writeln("---------------------------");

writeln([node in enumerateInAscendingOrder(root)] node.value);
writeln("---------------------------");

writeln("is balanced: ", isBalancedTree(root));
writeln("---------------------------");

balanceTree(root);
prettyPrint(root);
writeln("---------------------------");
