Particle p; // particle
PVector g; // gravity
PVector t; // tension
PVector c; // center
boolean cut = false;

void setup() {
	size(1213.5, 750);
  c = new PVector(width/2, height/2);
  p = new Particle(1, c.x + 200, c.y, 0, 10, color(255));
  g = new PVector(0, 0.5 * p.mass);
	background(0);
}

void draw() {
	fill(color(0, 256 / 4));
	rect(0, 0, width, height);
	// find tension
	t = PVector.sub(c, p.location);
	t.normalize();
	t.mult(p.velocity.magSq());
	t.mult(p.mass);
	t.div(p.location.dist(c));
	t.sub(g.get());
	p.applyForce(g);
	if(!cut) {
		p.applyForce(t);
	}
	p.update();
	p.checkEdges();
	p.display();
	fill(color(255, 0, 0, 256 / 4));
	noStroke();
	ellipse(c.x, c.y, 20, 20);
	if(!cut) {
		stroke(color(255));
		line(c.x, c.y, p.location.x, p.location.y);
	}
}

void keyPressed() {
	if(!cut) {
		cut = true;
	}
	else {
		cut = false;
		c = new PVector(width/2, height/2);
	  p = new Particle(1, c.x + 200, c.y, 0, 10, color(255));
	  g = new PVector(0, 0.5 * p.mass);
	}
}

void mousePressed() {
	keyPressed();
}