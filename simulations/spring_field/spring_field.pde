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
