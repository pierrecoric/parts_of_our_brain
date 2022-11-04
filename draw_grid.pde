void draw_grid() {
  //just draw a grid with nothing in it.
  for(int i = 0; i < steps; i ++) {
    for(int j = 0; j < 8; j ++) {
      noFill();
      rect(i*widthGridCell,j*heightGridCell,widthGridCell,heightGridCell);
    }
    //add a thicker line every 4 steps
    if (i % 4 == 3) {
      fill(255,255,255);
      rect(widthGridCell*(i+1)-3,0,6,height);
    }
  }
}
