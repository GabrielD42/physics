final float G = 0.0001;
final float k = 1;
final float m = 10000;
final int w = 1213.5; // 1213.5
final int h = 750;
final int distance = 100;
final int px = ceil(w/distance) + 3;
final int py = ceil(h/distance) + 3;
Particle[][] particles = new Particle[px][py];
ArrayList<Spring> springs = new ArrayList<Spring>();

void setup() {
	size(w, h);

	for(int x = 0; x < particles.length; x++) {
		for(int y = 0; y < particles[0].length; y++) {
			particles[x][y] = new Particle((x - 1) * distance, (y - 1) * distance, m);
		}
	}

	for(int x = 0; x < particles.length; x++) {
		for(int y = 0; y < particles[0].length; y++) {
			if(x < particles.length - 1) {
				springs.add(new Spring(particles[x][y], particles[x + 1][y], k));
			}
			if(y < particles[0].length - 1) {
				springs.add(new Spring(particles[x][y], particles[x][y + 1], k));
			}
		}
	}
}

void update() {
	for(int i = 0; i < springs.size(); i++) {
		springs.get(i).update();
	}

	Particle mouse = new Particle(mouseX, mouseY, m * 10);
	for(int x = 0; x < particles.length; x++) {
		for(int y = 0; y < particles[0].length; y++) {
			mouse.attract(particles[x][y]);
		}
	}


	// keep the ones on the outside the same
	for(int x = 1; x < particles.length - 1; x++) {
		for(int y = 1; y < particles[0].length - 1; y++) {
			particles[x][y].update();
		}
	}

}

void display() {
	background(0);
	for(int x = 0; x < particles.length; x++) {
		for(int y = 0; y < particles[0].length; y++) {
			fill(255);
			// particles[x][y].display();
		}
	}

	for(int i = 0; i < springs.size(); i++) {
		springs.get(i).display();
	}
}

void draw() {
	update();
	display();
}

////////////////////

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

////////////////////

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
