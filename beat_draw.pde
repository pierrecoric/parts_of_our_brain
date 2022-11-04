void beat_draw() {
  //two nested loops going through each element stored into the beat
  for(int i = 0; i < 8; i ++) {
    for(int j = 0; j < steps; j++) {
      //drawing a rectangle of the correct collor at the given location of each cell.
      switch(beat[i][j]) {
        case 0:
        fill(255);
        rect(j*widthGridCell,i*heightGridCell,widthGridCell,heightGridCell);
        break;
        case 1:
        fill(255,0,0);
        rect(j*widthGridCell,i*heightGridCell,widthGridCell,heightGridCell);
        break;
        case 2:
        fill(0,0,255);
        rect(j*widthGridCell,i*heightGridCell,widthGridCell,heightGridCell);
        break;
      }
    }
  }
}
