use Random;

const H = 0;

const PARITY_X  = 0;
const PARITY_Y  = 1;
const PARITY_Z  = 2;

type byte = uint(8);

var seed = 17;
var rand = new RandomStream(seed);

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

proc recoverParityCubeUsingParity(parity, cube) {

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
  for h in 0..H {
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

generateRandomCube(cubeA);
prettyPrintCube(cubeA);
computeParityForCube(cubeA, parity);
prettyPrintParity(parity);
recoverParityCubeUsingParity(parity, cubeB);
writeln(isEqualCubes(cubeA, cubeB));

