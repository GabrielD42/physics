class Particle {
	Particle(float x, float y, float m) {
		mass = m;
		location = new PVector(x, y);
		velocity = new PVector(0, 0);
		acceleration = new PVector(0, 0);
	}

	void update() {
		velocity.add(acceleration);
		location.add(velocity);
		acceleration.mult(0);
	}

	void display() {
		ellipse(location.x, location.y, 10, 10);
	}

	void applyForce(PVector force) {
		PVector f = PVector.div(force, mass);
		acceleration.add(f);
	}

	void attract(Particle p) {
		PVector force = PVector.sub(location, p.location);
		float distance = force.mag();
		distance = max(50, distance);
		force.normalize();
		float strength = (G * mass * p.mass) / (distance * distance);
		force.mult(strength);
		p.applyForce(force);
	}

	PVector location, velocity, acceleration;
	float mass;
};
