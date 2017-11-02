// create a GUI for all the variables possibles.
import controlP5.*;
ControlP5 bubbleSize, wind; // GUI variable name
int valmin, valmax;
float windmin, windmax; // variables in the GUI
Range range, rangeWind; // what this do?


ArrayList<Particle> bubbles = new ArrayList<Particle>();
PFont myFont;

void setup () {
  size(900, 700);
  // colorMode(RGB, 255);
	for (int i = 0; i < 400; i++) {
	  Particle p = new Particle(new PVector(random(-200, 600), height));
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
  .setBroadcast(false).setPosition(10,50).setSize(150,10).setHandleSize(3)
  .setRange(0,500).setRangeValues(10,40)
  // after the initialization we turn broadcast back on again
  .setBroadcast(true).setColorForeground(color(#F1B64D)).setColorBackground(color(51));

  // WIND ------------------------------------------------------------------
  wind = new ControlP5(this); // initialization
  rangeWind = wind.addRange("wind direction")
  // disable broadcasting since setRange and setRangeValues will trigger an event
  .setBroadcast(false).setPosition(10,70).setSize(200,20).setHandleSize(3)
  .setRange(-1,1).setRangeValues(-0.5,0.5)
  // after the initialization we turn broadcast back on again
  .setBroadcast(true).setColorForeground(color(#F1B64D)).setColorBackground(color(51));
}

void draw() {
  background(253);

  for (Particle p : bubbles) {
    p.show();
    p.move();
    p.edges(valmin, valmax, windmin, windmax);
  }
  // blendMode(REPLACE); //SUBTRACT
  fill(253);
  textFont(myFont);
  textSize(140); textAlign(CENTER);
  text("colours", width/2, height/2);
}


void keyPressed() {
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

  if(theControlEvent.isFrom("wind direction")) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
    windmin = int(theControlEvent.getController().getArrayValue(0));
    windmax = int(theControlEvent.getController().getArrayValue(1));
    // println("range update, done.");
  }

}

void mouseReleased( ) {
  for (Particle p : bubbles) {
    // p.windD(windmin, windmax);
  }
}
