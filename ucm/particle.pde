class Particle {
	Particle(float m, float x, float y, float vx, float vy, color c_) {
		mass = m;
		location = new PVector(x, y);
		velocity = new PVector(vx, vy);
		acceleration = new PVector(0, 0);
		c = c_;
	}

	void applyForce(PVector force) {
		PVector f = PVector.div(force, mass);
		acceleration.add(f);
	}

	void update() {
		velocity.add(acceleration);
		location.add(velocity);
		// println(acceleration);
		acceleration.mult(0);
	}

	void display() {
		noStroke();
		fill(c);
		ellipse(location.x, location.y, mass * 20, mass * 20);
	}

	void checkEdges() {
		if(location.x > width) {
			location.x = width;
			velocity.x *= -1;
		}
		else if(location.x < 0) {
			location.x = 0;
			velocity.x *= -1;
		}
		if(location.y > height) {
			location.y = height;
			velocity.y *= -1;
		}
		else if(location.y < 0) {
			location.y = 0;
			velocity.y *= -1;
		}
	}

	PVector location, velocity, acceleration;
	float mass;
	color c;
};