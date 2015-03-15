import java.util.*;

PShader effect;
long marriageDate = 669144600;
int timer;
int[] binDiff;
long diff;
int binDiffIndex;
int buffer = 20;
int spacing = 100;
int[] xs;
int[] ys;
float[] cols;

Tile[] Tiles;
Pixel[] Pixels;

void setup() {
  colorMode(HSB, 360, 100, 100);
  binDiff = new int[49];
  Tiles = new Tile[49];
  xs = new int[49];
  ys = new int[49];
  cols = new float[49];
  for(int y=0;y<7;y++) {
    for(int x=0;x<7;x++) {
      Tiles[x+y*7] = new Tile(x, y);
      xs[x+y*7] = x*spacing + buffer;
      ys[x+y*7] = y*spacing + buffer;
    }
  }
  for(int i=0; i<xs.length; i++) {
    println(xs[i]);
  }
  size(2*buffer+6*spacing, 2*buffer+6*spacing, P3D);
  effect = loadShader("ToonFrag.glsl", "ToonVert.glsl");
  effect.set("xs", xs);
  effect.set("ys", ys);
  effect.set("height", height);
}

void draw() {
  binDiffIndex = 0;
  Date now = new Date();
  diff = now.getTime() - marriageDate;
  convertToBin(diff);
  shader(effect);
  for(int i=0; i<49; i++) {
    cols[i] = Tiles[i].getCol();
    Tiles[i].update(binDiff[i]);
  }
    effect.set("cols", cols);

  rect(0, 0, width, height);
}

void convertToBin(long num) {
  binDiff[binDiffIndex] = (int)(num%2);
  num /= 2;
  binDiffIndex++;
  if(num > 0) {
    convertToBin(num);
  }
}
