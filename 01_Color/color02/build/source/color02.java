import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class color02 extends PApplet {

// create a GUI for all the variables possibles.

ControlP5 bubbleSize, wind; // GUI variable name
int valmin, valmax;
float windmin, windmax; // variables in the GUI
Range range, rangeWind; // what this do?


ArrayList<Particle> bubbles = new ArrayList<Particle>();
PFont myFont;

public void setup () {
  
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
  .setBroadcast(true).setColorForeground(color(0xffF1B64D)).setColorBackground(color(51));

  // WIND ------------------------------------------------------------------
  wind = new ControlP5(this); // initialization
  rangeWind = wind.addRange("wind direction")
  // disable broadcasting since setRange and setRangeValues will trigger an event
  .setBroadcast(false).setPosition(10,70).setSize(200,20).setHandleSize(3)
  .setRange(-1,1).setRangeValues(-0.5f,0.5f)
  // after the initialization we turn broadcast back on again
  .setBroadcast(true).setColorForeground(color(0xffF1B64D)).setColorBackground(color(51));
}

public void draw() {
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


public void keyPressed() {
  // saveFrame("screenShot##.png");
}

public void controlEvent(ControlEvent theControlEvent) {
  if(theControlEvent.isFrom("bubbles size")) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
    valmin = PApplet.parseInt(theControlEvent.getController().getArrayValue(0));
    valmax = PApplet.parseInt(theControlEvent.getController().getArrayValue(1));
    // println("range update, done.");
  }

  if(theControlEvent.isFrom("wind direction")) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
    windmin = PApplet.parseInt(theControlEvent.getController().getArrayValue(0));
    windmax = PApplet.parseInt(theControlEvent.getController().getArrayValue(1));
    // println("range update, done.");
  }

}

public void mouseReleased( ) {
  for (Particle p : bubbles) {
    // p.windD(windmin, windmax);
  }
}
class Particle {
  // Variables
  PVector pos, vel, acc;
	float t;
	int c;
  Particle(PVector pos) {
    // Inicialize the variables
    this.pos = pos;
		float r = random(1);
		if (r < .95f) {
			this.t = random(3, 15);
		} else {
			this.t = random(80, 130);
		}
		this.vel = new PVector(0, 0);
		this.acc = new PVector(random(.001f, .003f),random(-.004f, -.001f));
		c = color(random(255), random(255), random(255));
  }

  //  description
  public void show() {
		pushMatrix();
		// blendMode(MULTIPLY);
		noStroke();
		fill(c);
		ellipse(pos.x, pos.y, t, t);
		popMatrix();
  }

	public void move() {
	 vel.add(acc);
	 pos.add(vel);
	}

	public void edges(float valmin, float valmax, float x1, float x2) {
		if (pos.x < 0 || pos.x > width || pos.y < 0) {
			vel.mult(0);
			pos = new PVector(random(-250, 350), height * 1.1f);
			float r = random(1);
			if (r < .9f) {
				this.t = random(valmin, valmax);
			} else {
				this.t = random(80, 130);
			}
			c = color(random(255), random(255), random(255));
			// println(acc.x);
			acc.x = random(x1, x2);
		}
	}

	// windD
	// void windD (float x1, float x2, float y1, float y2) {
	public void windD (float x1, float x2) {
	  // acc = new PVector(random(x1, x2), acc.y);
	  acc.x = random(x1, x2);
	}
}
  public void settings() {  size(900, 700); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#0B1D3F", "--hide-stop", "color02" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
