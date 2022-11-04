void beat_init(int value) {
  //two nested loops to turn every ellement of the beat into a given value. (off at the launch of the script or when 0 is hit)
  for(int i = 0; i < 8; i ++) {
    for(int j = 0; j < steps; j ++) {
      beat[i][j] = value;
    }
  }
}
