abstract class Object extends Thing {
	Object(PVector arg_pos, PVector arg_vel, PVector arg_acc, float arg_mass, float arg_charge) {
		pos = arg_pos;
		vel = arg_vel;
		acc = arg_acc;
		mass = arg_mass;
		charge = arg_charge;
	}

	PVector pos, vel, acc;
	float mass, charge;
};
