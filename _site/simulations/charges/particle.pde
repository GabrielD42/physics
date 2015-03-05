class Particle extends Object {
	Particle(PVector arg_pos, PVector arg_vel, float arg_mass, float arg_charge, float arg_r) {
		super(arg_pos, arg_vel, new PVector(0, 0), arg_mass, arg_charge);
		r = arg_r;
	}
	void apply_force(PVector force) {
		acc.add(PVector.div(force, mass));
	}
	void react(Thing other) {
		if(this == other) {
			return;
		}
		if(other instanceof Particle) {
			Particle other_particle = (Particle)other;
			PVector force = PVector.sub(pos, other_particle.pos);
			float distance = force.mag();
			distance = max(5, distance);
			force.normalize();
			float strength = (G * mass * other_particle.mass) / (distance * distance);
			force.mult(strength);
			force.mult(-1);
			other_particle.apply_force(force);
		}
	}

	void update() {
		vel.add(acc);
		pos.add(vel);
		acc.mult(0);
	}
	void display() {
		ellipse(pos.x, pos.y, r, r);
	}

	float r;
};
