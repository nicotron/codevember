class Particle {
  // Variables
  PVector pos, vel, acc;
	float t, amt;
	color c, c1;
  Particle(PVector pos) {
    // Inicialize the variables
    this.pos = pos;
		float r = random(1);
		if (r < .95) {
			this.t = random(3, 15);
		} else {
			this.t = random(80, 100);
		}
		this.vel = new PVector(0, 0);
		this.acc = new PVector(random(.001, .003),random(-.004, -.001));
		c = color(0);
		c1 = color(255, 0, 255);
  }

  void show() {
		pushMatrix();
		noStroke();
		fill(c);
		ellipse(pos.x, pos.y, t, t);
		popMatrix();
  }

	void move() {
	 vel.add(acc);
	 pos.add(vel);
	}

	void edges(float valmin, float valmax, float x1, float x2) {
		if (pos.x < 0 || pos.x > width || pos.y < 0) {
			vel.mult(0);
			pos = new PVector(random(width * .2, width * .8), height * .7 + random(-50, 50));
			float r = random(1);
			if (r < .94) {
				this.t = random(valmin, valmax);
			} else {
				this.t = random(20, 40);
			}
		}
	}

	// windD
	// void windD (float x1, float x2, float y1, float y2) {
	void windD (float x1, float x2) {
	  // acc = new PVector(random(x1, x2), acc.y);
		float xx1 = map(x1, 0, 2, -.01, .01);
		float xx2 = map(x2, 0, 2, -.01, .01);
	  // this.acc = PVector.random2D();
	  this.acc.x = random(xx1, xx2);
		// this.acc.mult(.01);
	}

	void fade() {
	  this.c = lerpColor(this.c, c1, amt);
		amt += 0.01;
		if (pos.y > height /2) {
			t+= .05;
		} else {
			t-= .25;
		}
		if (t < 0) {t = 0;}
	}

	void changeColor (color c1) {
		this.c1 = c1;
		amt = 0;
	}
}
