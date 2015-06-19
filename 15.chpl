config const N = 2;

proc walk(x: int, y: int): int {
  if (x >= N || y >= N) {
    if (x == N && y == N) {
      return 1;
    } else if (x > N || y > N) {
      return 0;
    }
  }

  return walk(x + 1, y) + walk(x, y + 1);
}

writeln(walk(0, 0));
