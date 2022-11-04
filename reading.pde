void reading(int position) {
  //displaying the reading bar
  position = position + 1;
  noFill();
  stroke(0);
  strokeWeight(4);
  rect((position*widthGridCell) - widthGridCell,0,widthGridCell,height);
}
