// create a GUI for all the variables possibles.
import controlP5.*;
ControlP5 bubbleSize, wind; // GUI variable name
float valmin, valmax, windmin, windmax; // variables in the GUI
Range range, rangeWind; // what this do?

ArrayList<Particle> bubbles = new ArrayList<Particle>();
PFont myFont;

void setup () {
  size(900, 700);
  // colorMode(RGB, 255);
	for (int i = 0; i < 40; i++) {
	  Particle p = new Particle(new PVector(random(200, 600), height * .8));
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
  .setRange(0,2).setRangeValues(0,1)
  .setBroadcast(true).setColorForeground(color(#F1B64D)).setColorBackground(color(51));
}

void draw() {
  background(253);

  for (Particle p : bubbles) {
    p.show();
    p.move();
    p.edges(valmin, valmax, windmin, windmax);
    p.windD(windmin, windmax);
    p.grow();
  }
  // blendMode(REPLACE); //SUBTRACT
  fill(53);
  textFont(myFont);
  textSize(140); textAlign(CENTER);
  text("colours", width/2, height/2, 250);
}


void mousePressed() {
  // saveFrame("screenShot##.png");

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
