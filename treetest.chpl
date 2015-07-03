use Tree;

var root = generateRandomTree(10);
prettyPrint(root);
writeln("---------------------------");

root = rotateRight(root);
prettyPrint(root);
writeln("---------------------------");

root = rotateLeft(root);
prettyPrint(root);
writeln("---------------------------");

writeln([i in enumerateInDescendingOrder(root)] i);
writeln("---------------------------");

writeln([i in enumerateInAscendingOrder(root)] i);
writeln("---------------------------");
