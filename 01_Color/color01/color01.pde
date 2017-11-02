ArrayList<Particle> bubbles = new ArrayList<Particle>();
PFont myFont;

void setup () {
  size(900, 700);
  colorMode(RGB, 255);
	for (int i = 0; i < 400; i++) {
	  Particle p = new Particle(new PVector(random(-200, 600), height));
	  // Particle p = new Particle(new PVector(width/2, height/2));
    bubbles.add(p);
	}
  // String[] fontList = PFont.list();
  // printArray(fontList);
  myFont = createFont("Calibri-Bold", 240);
}

void draw() {
  background(253);


  for (Particle p : bubbles) {
    p.show();
    p.move();
    p.edges();
  }
  blendMode(REPLACE); //SUBTRACT
  fill(253);
  textFont(myFont);
  textSize(140); textAlign(CENTER);
  text("colours", width/2, height/2);
}


void keyPressed() {
  saveFrame("screenShot##.png");
}
