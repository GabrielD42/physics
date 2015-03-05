abstract class Thing {
	// a force is applied to this thing
	abstract void apply_force(PVector force);
	// how should this thing react to some other thing?
	abstract void react(Thing other);
	// update state
	abstract void update();
	// display thing
	abstract void display();
};
