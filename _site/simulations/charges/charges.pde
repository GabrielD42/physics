System s = new System();

void setup() {
	size(1000, 1000);

	for(int i = 0; i < 100; i++) {
		s.objects.add(new Particle(new PVector(random(0, width), random(0, height)), new PVector(random(-2.0, 2.0), random(-2.0, 2.0)), random(10, 50), random(-5, 5), random(10, 50)));
	}
}

void draw() {
	s.react(s);
	s.update();
	s.display();
}
