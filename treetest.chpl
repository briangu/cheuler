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

for i in enumerateInOrder(root) {
  writeln(i);
}
writeln("---------------------------");

