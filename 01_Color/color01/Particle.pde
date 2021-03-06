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
		blendMode(MULTIPLY);
		noStroke();
		fill(c);
		ellipse(pos.x, pos.y, t, t);
		popMatrix();
  }

	void move() {
	 vel.add(acc);
	 pos.add(vel);
	}

	void edges() {
		if (pos.x < 0 || pos.x > width || pos.y < 0) {
			vel.mult(0);
			pos = new PVector(random(-250, 350), height * 1.1);
			float r = random(1);
			if (r < .9) {
				this.t = random(3, 30);
			} else {
				this.t = random(80, 130);
			}
			c = color(random(255), random(255), random(255));
		}
	}
}
