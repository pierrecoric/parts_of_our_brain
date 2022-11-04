void load_pattern(int value) {
  //two nested loops to load a given pattern
  for(int i = 0; i < 8; i ++) {
    for(int j = 0; j < steps; j ++) {
      beat[i][j] = savedPatterns[value][i][j];
    }
  }
}
