void play (int position) {
  //going over every 8 instruments at a given position and turning the relays on or off according to the states of the cells.
  for(int i = 0; i < 8; i ++) {
    switch(beat[i][position]) {
      case(1):
      arduino.digitalWrite(relay[i], Arduino.HIGH);
      break;
      case(2):
      arduino.digitalWrite(relay[i], Arduino.LOW);
      break;
    }
  }
}
