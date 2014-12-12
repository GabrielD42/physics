class Spring {
	Spring(Particle p1_, Particle p2_, float k) {
		p1 = p1_;
		p2 = p2_;
		springConstant = k;
		length = PVector.sub(p1.location, p2.location).mag();
	}
	// broken
	void update() {
		PVector force = PVector.sub(p1.location, p2.location);
		float distance = force.mag();
		float stretch = distance - length;
		force.normalize();
		force.mult(-1 * springConstant * stretch);
		p1.applyForce(force);
		force = PVector.sub(p2.location, p1.location);
		distance = force.mag();
		stretch = distance - length;
		force.normalize();
		force.mult(-1 * springConstant * stretch);
		p2.applyForce(force);
	}

	void display() {
		float distance = abs(PVector.sub(p1.location, p2.location).mag());
		float opacity = constrain(length / distance * 100, length / 2, length * 2);
		opacity = map(opacity, length / 2, length * 2, 0, 255);
		float thickness = map(opacity, 0, 255, 1, 10);
		stroke(255, opacity);
		strokeWeight(thickness);
		line(p1.location.x, p1.location.y, p2.location.x, p2.location.y);
	}

	Particle p1, p2;
	float length, springConstant;
};
