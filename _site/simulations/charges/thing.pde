class Thing {
	Thing(float m, float x, float y, color c_) {
		mass = m;
		location = new PVector(x, y);
		velocity = new PVector(0, 0);
		acceleration = new PVector(0, 0);
		c = c_;
	}

	void applyForce(PVector force) {
		PVector f = PVector.div(force, mass);
		acceleration.add(f);
	}

	PVector attract(Thing t) {
		PVector force = PVector.sub(location, t.location);
		float distance = force.mag();
		distance = max(5, distance);
		force.normalize();
		float strength = (G * mass * t.mass) / (distance * distance);
		force.mult(strength);
		return force;
	}

	PVector repel(Thing t) {
		PVector force = attract(t);
		force.mult(-1);
		return force;
	}

	void update() {
		velocity.add(acceleration);
		location.add(velocity);
		acceleration.mult(0);
	}

	void display() {
		// nothing to see here, move along
	}

	void checkEdges() {
		if(location.x >= width) {
			location.x = width;
			velocity.x *= -1;
		}
		else if(location.x <= 0) {
			location.x = 0;
			velocity.x *= -1;
		}
		if(location.y >= height) {
			location.y = height;
			velocity.y *= -1;
		}
		else if(location.y <= 0) {
			location.y = 0;
			velocity.y *= -1;
		}
	}

	PVector location, velocity, acceleration;
	float mass;
	color c;
};
