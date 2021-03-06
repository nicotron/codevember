class Particle {
  // Variables
  PVector pos, vel, acc;
	float t;
	color c;
  Particle(PVector pos) {
    // Inicialize the variables
    this.pos = pos;
		float r = random(1);
		if (r < .95) {
			this.t = random(3, 15);
		} else {
			this.t = random(80, 130);
		}
		this.vel = new PVector(0, 0);
		this.acc = new PVector(random(.001, .003),random(-.004, -.001));
		c = color(random(255), random(255), random(255));
  }

  //  description
  void show() {
		pushMatrix();
		// blendMode(MULTIPLY);
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
			pos = new PVector(random(250, 350), height * .8);
			float r = random(1);
			if (r < .9) {
				this.t = random(valmin, valmax);
			} else {
				this.t = random(40, 90);
			}
			c = color(random(255), random(255), random(255));
			// println(acc.x);
		}
		// this.acc.x = random(x1, x2);
	}

	// windD
	// void windD (float x1, float x2, float y1, float y2) {
	void windD (float x1, float x2) {
	  // acc = new PVector(random(x1, x2), acc.y);
		float xx1 = map(x1, 0, 2, -.01, .01);
		float xx2 = map(x2, 0, 2, -.01, .01);
	  this.acc.x = random(xx1, xx2);
	}

	void grow() {
		float d = dist(pos.x, pos.y, width * .5, height * .5);
		t = map(d, 0, 500, 200, 0);

	}
}
