int block_width = 50;

ArrayList<Block> blocks = new ArrayList<Block>();

void setup() {
	// size(1213.5, 750);
	size(1214, 750);
	blocks.add(new Block(50, 50, 5, color(44, 131, 140)));
	blocks.add(new Block(width - 150, 100, -5, color(8, 102, 104)));
}

void draw() {
	background(0);
	int opacity = 255;
	stroke(255);
	for(int y = height / 2 + 50; y <= height; y++) {
		stroke(52, 73, 94, opacity);
		line(0, y, width, y);
		opacity -= 1;
	}
	noStroke();
	for(int i = 0; i < blocks.size(); i++) {
		((Block)blocks.get(i)).update();
	}
	for(int i = 0; i < blocks.size() - 1; i++) {
		for(int j = i + 1; j < blocks.size(); j++) {
			((Block)blocks.get(i)).collide((Block)blocks.get(j));
			((Block)blocks.get(j)).collide((Block)blocks.get(i));
		}
	}
	for(int i = 0; i < blocks.size(); i++) {
		((Block)blocks.get(i)).display();
	}

	// center of mass
	float com = 0;
	float masses = 0;
	for(Block b : blocks) {
		com += b.x * b.m;
		masses += b.m;
	}
	com /= masses;
	stroke(0);
	fill(255);
	triangle(com, height / 2 + 50, com - 20, height / 2 + 100, com + 20, height / 2 + 100);
}

void mouseClicked() {
	colorMode(HSB, 360);
	blocks.add(new Block(mouseX, random(25, 500), random(-5, 5), color(random(180, 240), random(120, 270), random(180, 240))));
	colorMode(RGB, 255);
}

////////////////////

class Block {
	Block(float x_, float m_, float v_, color c_) {
		x = x_;
		m = m_;
		vi = v_;
		vchanged = false;
		c = c_;
	}
	void collide(Block other) {
		if((x >= other.x && x <= (other.x + block_width)) || ((x + block_width) >= other.x && (x + block_width) <= (other.x + block_width))) {
			vf = ((m - other.m)/(m + other.m)) * vi + ((2 * other.m)/(m + other.m)) * other.vi;
			vchanged = true;
		}
	}
	void update() {
		if(x <= 0 || x + block_width >= width) {
			vf = -1 * vi;
			vchanged = true;
		}
		if(!vchanged) {
			vf = vi;
		}
		x += vf;
		vi = vf;
	}
	void display() {
		fill(c);
		rect(x, height / 2, block_width, 50);
	}
	float x, m, vi, vf;
	boolean vchanged;
	color c;
};
