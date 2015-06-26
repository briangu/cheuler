config const Filename = "22.dat";

iter nameScoresFromFile(filename: string) {
  var f = open(filename, iomode.r);
  var position = 1;
  for line in f.lines() {
    var score = 0;
    for i in 1..line.length-1 {
      score += ascii(line.substring(i..i)) - ascii("A") + 1;
    }
    yield score * position;
    position += 1;
  }
  f.close();
}

writeln(+ reduce [i in nameScoresFromFile(Filename)] i);
