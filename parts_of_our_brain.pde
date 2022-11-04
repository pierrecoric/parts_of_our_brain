//Libraries to communicate with the arduino
import processing.serial.*;
import cc.arduino.*;
//defining an arduino
Arduino arduino;
//variable to store the width and the height of one cell of the grid
float widthGridCell;
float heightGridCell;
//two dimensional array to save the beat being played
//[amount of instruments][steps of the sequencer]
int [][] beat = new int [8][32];
//three dimensional array to store 4 beat patterns.
//[amount of savable patterns][amount of instruments][steps of the sequencer]
int [][][] savedPatterns = new int [4][8][32];
//amount of steps on the sequencer
int steps = 32;
//variable to register actions on click (turning a cell on or off)
//2 = blue = off
//1 = red = on
int action = 0;
//variables to store the computed position of the mouse
int xPos = 0;
int yPos = 0;
//variables to manage time
int startMillis = 0;
int currentMillis = 0;
//variable to store the base time
int absolutePeriod = 1000;
//variable to further store the result of the division of the absoluteperiode
int period = 1000;
//Absolute counter through time
int positionAbsolute = 0;
//Recurring counter every n steps
int position = 0;
//array to store the pin numbers of the relays on the arduino
int relay [] = new int [8];

void setup() {
  //Uncomment the below to print the list of ports on which the arduino could be
  //print(Arduino.list());
  //you might have to change the number between [] to access the port on which the arduino is connected
  arduino = new Arduino(this, Arduino.list()[3], 57600);
  //loop to give a pin number to each relay
  for(int i = 0; i < 8; i ++) {
    //relay 1 = pin 2, relay 2 = pin 3 etc
    relay[i] = i + 2;
    //setting those pins as Output
    arduino.pinMode(relay[i], Arduino.OUTPUT);
  }
  //starting to record time
  startMillis = millis();
  //size(1280,480);
  //entering Full Screen
  fullScreen();
  //computing the width and the height of the cells of the grid
  widthGridCell = width/steps;
  heightGridCell = height/8;
  //initialise the beat by turning every relay off throughout the sequence.
  beat_init(1);
}

void draw() {
  //white thin stroke
  stroke(255);
  strokeWeight(1);
  //cells_manage is actually now a useless function
  //cells_manage();
  //calling beat_draw() to represent the played beat onto the grid.
  beat_draw();
  //Just drawing a white grid with a thicker line every 4 steps.
  draw_grid();
  //checking what's upp with time
  currentMillis = millis();
  //every time the period is over:
  if (currentMillis - startMillis >= period) {
    //increase the position of th reading line
    positionAbsolute ++;
    position = (positionAbsolute%steps);
    startMillis = currentMillis;
  }
  //displaying the bar
  reading(position);
  //managing the relays
  play(position);
  //register position of the mouse
  xPos = int(mouseX/widthGridCell);
  yPos = int(mouseY/heightGridCell); 
  //saving us from the array out of range by limiting those values to the dimensions of the array. (so it does not crash if the mouse escape the corner of the window)
  if (xPos > steps - 1){
    xPos = steps - 1;
  }
  if (xPos < 0) {
    xPos = 0;
  }
  if (yPos > 8 - 1) {
    yPos = 8 -1;
  }
  if (yPos < 0) {
    yPos = 0;
  }
  //register mouse actions
  if (mousePressed && (mouseButton == LEFT)) {
    action = 2;
    register_action(action);
  }
  else if (mousePressed && (mouseButton == RIGHT)) {
    action = 1;
    register_action(action);
  }
  //key control
  if (keyPressed == true) {
    //manage tempo, time division
    if (key == '4') {
      period = absolutePeriod / 8;
    }
    if (key == '3') {
      period = absolutePeriod / 4;
    }
    if (key == '2') {
      period = absolutePeriod / 2;
    }
    if (key == '1') {
      period = absolutePeriod / 1;
    }
    //surprise
    if (key == 'm') {
      period = absolutePeriod / 32;
    }
    if (key == 'n') {
      period = absolutePeriod / 16;
    }
    
    //save patterns, keys 5 to 8
    if (key == '5') {
      save_pattern(0);
    }
    if (key == '6') {
      save_pattern(1);
    }
    if (key == '7') {
      save_pattern(2);
    }
    if (key == '8') {
      save_pattern(3);
    }
    
    //load patterns
    if (key == 't') {
      load_pattern(0);
    }
    if (key == 'y') {
      load_pattern(1);
    }
    if (key == 'u') {
      load_pattern(2);
    }
    if (key == 'i') {
      load_pattern(3);
    }
    
    //clear everything
    if (key == '0') {
      beat_init(1);
    }
  }
}

void mouseReleased() {
  action = 1;
}
