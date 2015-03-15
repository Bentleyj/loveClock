class Pixel {
  int x, y;
  float[] weights;

  public Pixel(int _x, int _y) {
    x = _x;
    y = _y;
    weights = new float[49];
  }

  void calcWeights(Tile[] tiles) {
    for (int i=0; i<Tiles.length; i++) {
      float xd = x - Tiles[i].x;
      float yd = y - Tiles[i].y;
      float dist = sqrt(xd*xd + yd*yd);
      float weighted = map(dist, 0, spacing, 1, 0);
      if (weighted < 0) weighted = 0;
      if (weighted > 1) weighted = 1;
      weights[i] = weighted;
    }
  }

  void display(Tile[] Tiles) {
    int col = 0;
    for (int i=0; i<weights.length; i++) {
      //if (weights[i] > 0) {
        col += weights[i] * Tiles[i].getCol();
      //}
    }
    stroke(col, 90, 90);
    point(x, y);
  }
}

