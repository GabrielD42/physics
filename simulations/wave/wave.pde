final float G = 1;
final float m = 1;
final int w = 1214; // 1213.5
final int h = 750;
final int distance = 50;
final int np = 1000;
Particle[] particles = new Particle[np];

void setup() {
	size(w, h, P3D);

	particles[0] = new Particle(distance, height / 4, m);
	for(int i = 1; i < particles.length; i++) {
		particles[i] = new Particle(i * distance + distance, height / 2, m);
	}
}

void update() {
	particles[0].applyForce(-0.01 * (particles[0].location.y - (height / 2)));
	particles[0].update();
	for(int i = 1; i < particles.length; i++) {
		float change = particles[i - 1].location.y - particles[i].location.y;
		change *= 0.5;
		particles[i].location.y += change;
	}
	for(int i = 1; i < particles.length; i++) {
		particles[i].update();
	}
}

void display() {
	background(0);
	translate(width / 2, height / 2 + 200, -200);
	rotateY(QUARTER_PI);
	// rotateX(-1);
	float(255);
	stroke(255);
	for(int i = 0; i < particles.length - 1; i++) {
		// line(particles[i].location.x, particles[i].location.y, particles[i + 1].location.x, particles[i + 1].location.y);
		particles[i].display();
	}
	particles[particles.length - 1].display();
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
		velocity = 0;
		acceleration = 0;
	}

	void update() {
		velocity += acceleration;
		location.y += velocity;
		acceleration = 0;
	}

	void display() {
		pushMatrix();
		// translate(location.x, location.y, 0);
		line(location.x, location.y, 0, location.x, location.y, -1000);
		// sphere(10);
		// ellipse(location.x, location.y, 10, 10);
		popMatrix();
	}

	void applyForce(float force) {
		acceleration += (force / mass);
	}

	PVector location;
	float velocity, acceleration;
	float mass;
};
