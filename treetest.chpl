use Tree;

config const N = 10;
config const M = N;

var root = generateRandomTree(N, M);
prettyPrint(root);
writeln("1 ---------------------------");

writeln("tree height = ", treeHeight(root));
writeln("2 ---------------------------");

root = rotateRight(root);
prettyPrint(root);
writeln("3 ---------------------------");

root = rotateLeft(root);
prettyPrint(root);
writeln("4 ---------------------------");

writeln([node in enumerateInDescendingOrder(root)] node.value);
writeln("5 ---------------------------");

writeln([node in enumerateInAscendingOrder(root)] node.value);
writeln("6 ---------------------------");

writeln("is balanced: ", isBalancedTree(root));
writeln("7 ---------------------------");

balanceTree(root);
prettyPrint(root);
writeln("8 ---------------------------");
