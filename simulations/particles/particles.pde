Mover[] movers = new Mover[20];

final float G = 0.25;

void setup() {
	doResize();
	for(int i = 0; i < movers.length; i++) {
		movers[i] = new Mover(10, random(0, width), random(0, height), color(31, 86, 115));
	}
}

void draw() {
	background(20, 56, 75);
	for(int i = 0; i < movers.length; i++) {
		for(int j = 0; j < movers.length; j++) {
			if(movers[i] != movers[j]) {
				if(movers[i].location.dist(movers[j].location) < 100) {
					PVector f = movers[j].attract(movers[i]);
					movers[i].applyForce(f);
				}
			}
		}
		movers[i].update();
		movers[i].checkEdges();
	}
	for(int i = 0; i < movers.length; i++) {
		for(int j = 0; j < movers.length; j++) {
			if(movers[i] != movers[j]) {
				if(movers[i].location.dist(movers[j].location) < 100) {
					stroke(31, 86, 115);
					line(movers[i].location.x, movers[i].location.y, movers[j].location.x, movers[j].location.y);
				}
				movers[i].display();
			}
		}
	}
}

// comment out for not web
function doResize() {
	$('#header-background').width($(window).width());
	$('#header-background').height($("header").outerHeight());
	size($(window).width(), $("header").outerHeight());
}
$(window).resize(doResize);


////////////////////

class Mover {
	Mover(float m, float x, float y, color c_) {
		mass = m;
		location = new PVector(x, y);
		velocity = new PVector(0, 0);
		acceleration = new PVector(0, 0);
		c = c_;
	}

	PVector attract(Mover m) {
		PVector force = PVector.sub(location, m.location);
		float distance = force.mag();
		distance = constrain(distance, 5, 25);
		force.normalize();
		float strength = (G * mass * m.mass) / (distance * distance);
		force.mult(strength);
		force.mult(-1);
		return force;
	}

	void applyForce(PVector force) {
		PVector f = PVector.div(force, mass);
		acceleration.add(f);
	}

	void update() {
		velocity.add(acceleration);
		location.add(velocity);
		acceleration.mult(0);
	}

	void display() {
		noStroke();
		fill(c);
		ellipse(location.x, location.y, mass, mass);
	}

	void checkEdges() {
		if(location.x > width + 25) {
			location.x = -25;
		}
		else if(location.x < -25) {
			location.x = width + 25;
		}
		if(location.y > height + 25) {
			location.y = -25;
		}
		else if(location.y < -25) {
			location.y = height + 25;
		}
	}

	PVector location, velocity, acceleration;
	float mass;
	color c;
};
