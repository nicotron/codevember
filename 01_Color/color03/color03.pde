// create a GUI for all the variables possibles.
import controlP5.*;
ControlP5 bubbleSize, wind, cColor; // GUI variable name
float valmin, valmax, windmin, windmax; // variables in the GUI
color c, c1; float amt;
Range range, rangeWind; // what this do?

ArrayList<Particle> bubbles = new ArrayList<Particle>();
PFont myFont;

void setup () {
  size(900, 600);
  // colorMode(RGB, 255);
	for (int i = 0; i < 1; i++) {
	  Particle p = new Particle(new PVector(random(200, 600), height * .5));
	  // Particle p = new Particle(new PVector(width/2, height/2));
    bubbles.add(p);
	}
  // String[] fontList = PFont.list();
  // printArray(fontList);
  myFont = createFont("Calibri-Bold", 240);

  // GUI ---------------------------------------------------------------------
  // BUBBLES -----------------------------------------------------------------
  bubbleSize = new ControlP5(this); // initialization
  range = bubbleSize.addRange("bubbles size")
  // disable broadcasting since setRange and setRangeValues will trigger an event
  .setBroadcast(false).setPosition(10,10).setSize(100,10).setHandleSize(3)
  .setRange(0,100).setRangeValues(10,40)
  // after the initialization we turn broadcast back on again
  .setBroadcast(true).setColorForeground(color(#F1B64D)).setColorBackground(color(51));

  // WIND ------------------------------------------------------------------
  wind = new ControlP5(this); // initialization
  rangeWind = wind.addRange("wind direction")
  .setBroadcast(false).setPosition(10,25).setSize(100,10).setHandleSize(3)
  .setRange(0,2).setRangeValues(.5,1.5)
  .setBroadcast(true).setColorForeground(color(#F1B64D)).setColorBackground(color(51));

  // COLOR ------------------------------------------------------------------
  // cColor = new ControlP5(this);
  // cColor.addColorWheel("c", 250, 50, 200).setRGB(color(100, 0, 255));
}

void draw() {
  background(253);

  color cc = color(random(255), random(255), random(255));
    for (Particle p : bubbles) {
    p.show();
    p.move();
    p.edges(valmin, valmax, windmin, windmax);
    p.windD(windmin, windmax);
    p.fade();
    if (frameCount % 120 == 0){
      p.changeColor(cc);
    }
  }

  stroke(cc);
  fill(253);
  textFont(myFont);
  textSize(140); textAlign(CENTER);
  text("colours", width/2, height/2);
}


void keyPressed() {
  if (key == ' ') {
    saveFrame("screenShot##.png");
  }
  if (key == '+') {
    for (int i = 0; i < 500; i++) {
  	  Particle p = new Particle(new PVector(random(200, 600), height * .5));
  	  // Particle p = new Particle(new PVector(width/2, height/2));
      bubbles.add(p);
  	}
  }
}

void controlEvent(ControlEvent theControlEvent) {
  if(theControlEvent.isFrom("bubbles size")) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
    valmin = int(theControlEvent.getController().getArrayValue(0));
    valmax = int(theControlEvent.getController().getArrayValue(1));
    // println("range update, done.");
  }
  else if(theControlEvent.isFrom("wind direction")) {
    windmin = int(theControlEvent.getController().getArrayValue(0));
    windmax = int(theControlEvent.getController().getArrayValue(1));
  }
}

void mouseReleased( ) {
  for (Particle p : bubbles) {
    // p.windD(windmin, windmax);
  }
}

// color c, c1;
// float amt;
// void setup () {
//   size(500, 500);
//   c = color(0);
//   //Inicialize variables
// }
//
// void draw() {
//   background(255);
//   fill(255, 0, 255);
//   ellipse(250, 270, 50, 50);
//   fill(c); noStroke();
//   ellipse(250, 250, 50, 50);
//
//  if(mousePressed) {
//    c1 = color(random(255), random(255), random(255));
//    amt = 0;
//  }
//
//   amt += 0.001;
//   c = lerpColor(c, c1, amt);
// }
