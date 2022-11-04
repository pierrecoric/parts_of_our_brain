void save_pattern(int value) {
  //two nested loops to save a given pattern
  for(int i = 0; i < 8; i ++) {
    for(int j = 0; j < steps; j ++) {
      savedPatterns[value][i][j] = beat[i][j];
    }
  }
}
