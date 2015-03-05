class Vector extends Thing {
	Vector(PVector arg_pos, float arg_mass, float arg_charge, float arg_r) {
		pos = new Particle(arg_pos, new PVector(0, 0), 0, 0, arg_r);
		end = new Particle(arg_pos, new PVector(0, 0), arg_mass, arg_charge, 0);
	}
	void apply_force(PVector force) {
		end.apply_force(force);
	}
	void react(Thing other) {
		// vectors are passive, they just reflect conditions
	}
	void update() {
		end.update();
	}
	void display() {
		line(pos.pos.x, pos.pos.y, end.pos.x, end.pos.y);
		pos.display();
	}

	Particle pos, end;
};
