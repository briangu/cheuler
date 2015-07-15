var mapDom: domain(int(32));
var map: [mapDom] string;
map[ascii("1")] = "";
map[ascii("2")] = "ABC";
map[ascii("3")] = "DEF";
map[ascii("4")] = "GHI";
map[ascii("5")] = "JKL";
map[ascii("6")] = "MNO";
map[ascii("7")] = "PQRS";
map[ascii("8")] = "TUV";
map[ascii("9")] = "WXYZ";

proc listCharacters(number: string, prefix = "") {
  if (number.length == 0) {
    writeln(prefix);
    return;
  }

  var letters = map[ascii(number.substring(1..1))];
  if (letters.length > 0) {
    for j in 1..letters.length {
        listCharacters(
          number.substring(2..number.length),
          prefix + letters.substring(j..j));
    }
  } else {
    if (number.length == 1) {
      writeln(prefix);
    } else {
      listCharacters(number.substring(2..number.length), prefix);
    }
  }
}

var number: string;
number = "3213"; writeln(number); listCharacters(number);
number = "1111"; writeln(number); listCharacters(number);
number = "1234"; writeln(number); listCharacters(number);
