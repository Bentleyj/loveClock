class Tile {
  int x, y;
  float col;
  boolean rising;
  
  public Tile(int _x, int _y) {
    x = _x*spacing + buffer;
    y = _y*spacing + buffer;
    col = 0;
    rising = true;
  }
  
  void update(int val) {
    if(val == 1) {
      if(rising) {
        col++;
        if(col == 360) rising = false;
      } else {
        col--;
        if(col == 0) rising = true;
      }
    }
  }
  
  float getCol() {
    return map(col, 0.0, 360.0, 0.0, 1.0);
  } 
  
  void display() {
    pushStyle();
    fill(360);
    ellipse(x, y, 10, 10);
    popStyle();
  }
}
