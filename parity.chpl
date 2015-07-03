use Random;

const H = 0;

const PARITY_X  = 0;
const PARITY_Y  = 1;
const PARITY_Z  = 2;

type byte = uint(8);

var seed = 17;
var rand = new RandomStream(seed);

var referenceParity: [0..1][0..127] byte;

proc computeReferenceParity(referenceParity) {
  var odd = 0;
  var even = 0;
  for i in 0..255 {
    var b = i: byte;
    if (parityForByte(b)) {
      referenceParity[1][odd] = b;
      odd += 1;
    } else {
      referenceParity[1][even] = b;
      even += 1;
    }
  }
}

// temporarily use the slow method until a table is built
proc popcount(b: byte): byte {
  var n = b;
  var i = 0;
  while (n != 0) {
    if (n & 1) {
      i += 1;
    }
    n >>= 1;
  }
  return i: byte;
}

proc parityForByte(b: byte): byte {
  return if (popcount(b) % 2) == 0 then 0: byte else 1: byte;
}

proc computeParityForCube(cube, parity) {
  for h in 0..H {
    // TODO: how to vectorize initialization?
    parity[PARITY_X] = 0: byte;
    parity[PARITY_Y] = 0: byte;
    parity[PARITY_Z] = 0: byte;

    for i in 0..7 {
      parity[PARITY_X][h] ^= cube[h][i];
      parity[PARITY_Y][h] |= parityForByte(cube[h][i]) << i;
      parity[PARITY_Z][i] ^= cube[h][i];
    }
  }
}

inline proc parityBitForByte(b: byte, pos: int) {
  return (b >> pos) & 0x1;
}

proc recoverCubeUsingParity(parity, cube) {
  var h = 0;
  var count: atomic int;

  forall a in referenceParity[parityBitForByte(parity[PARITY_X][h], 0)] {
    var cpA = a;
    forall b in referenceParity[parityBitForByte(parity[PARITY_X][h], 1)] {
      var cpB = cpA ^ b;
      forall c in referenceParity[parityBitForByte(parity[PARITY_X][h], 2)] {
        var cpC = cpB ^ c;
        forall d in referenceParity[parityBitForByte(parity[PARITY_X][h], 3)] {
          var cpD = cpC ^ d;
          forall e in referenceParity[parityBitForByte(parity[PARITY_X][h], 4)] {
            var cpE = cpD ^ e;
            forall f in referenceParity[parityBitForByte(parity[PARITY_X][h], 5)] {
              var cpF = cpE ^ f;
              forall g in referenceParity[parityBitForByte(parity[PARITY_X][h], 6)] {
                var cpG = cpF ^ g;
                forall h in referenceParity[parityBitForByte(parity[PARITY_X][h], 7)] {
                  var cpH = cpG ^ h;
                  if (cpH == parity[PARITY_X][h]) {
                    count.add(1);
                    if (count.read() % 100000 == 0) {
                      write("+");
                      if (count.read() % 1000000 == 0) {
                        writeln();
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  writeln("matching cube count: ", count.read());
}

proc isValidParityConfiguration(parity, cube): bool {
  var computedParity: [0..2][0..7] byte;
  computeParityForCube(cube, computedParity);
  return isEqualParity(parity, computedParity);
}

proc isEqualParity(parityA, parityB): bool {
  // TODO: vector compare?
  for h in 0..2 {
    for i in 0..7 {
      if (parityA[h][i] != parityB[h][i]) {
        return false;
      }
    }
  }

  return true;
}

proc isEqualCubes(cubeA, cubeB): bool {
  // TODO: vector compare?
  for h in 0..H {
    for i in 0..7 {
      if (cubeA[h][i] != cubeB[h][i]) {
        return false;
      }
    }
  }

  return true;
}

proc nextRandomByte(): byte {
  return (rand.getNext() * 255): byte;
}

proc generateRandomCube(cube) {
  for h in 0..H {
    for i in 0..7 {
      cube[h][i] = nextRandomByte();
    }
  }
}

proc prettyPrintByte(b: byte) {
  for x in 0..7 {
     writef("%bu", (b >> (7 - x)) & 0x1);
  }
}

proc prettyPrintCube(cube) {
  for h in 0..H {
    for i in 0..7 {
      prettyPrintByte(cube[h][i]);
      writeln();
    }
    writeln();
  }
}

proc prettyPrintParity(parity) {
  for h in 0..2 {
    writef("  ");
    prettyPrintByte(parity[PARITY_X][h]);
    writeln();
    for i in 0..7 {
      writef("%bu ", (parity[PARITY_Y][h] >> i) & 0x1);
      prettyPrintByte(parity[PARITY_Z][i]);
      writeln();
    }
    writeln();
  }
}

var cubeA: [0..H][0..7] byte;
var cubeB: [0..H][0..7] byte;
var parity: [0..2][0..7] byte;

computeReferenceParity(referenceParity);

writeln(isEqualCubes(cubeA, cubeB));
writeln(isEqualParity(parity, parity));

generateRandomCube(cubeA);
prettyPrintCube(cubeA);
computeParityForCube(cubeA, parity);
prettyPrintParity(parity);
recoverCubeUsingParity(parity, cubeB);
writeln(isEqualCubes(cubeA, cubeB));

