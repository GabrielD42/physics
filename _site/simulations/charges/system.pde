class System extends Thing {
	System() {
		objects = new ArrayList<Object>();
	}
	void apply_force(PVector force) {
		for (Object object : objects) {
			object.apply_force(force);
		}
	}
	void react(Thing other) {
		if(other instanceof System) {
			System other_system = (System)other;
			for(Object other_object : other_system.objects) {
				for(Object object : objects) {
					object.react(other_object);
				}
			}
		}
		else {
			for(Object object : objects) {
				object.react(other);
			}
		}
	}
	void update() {
		for (Object object : objects) {
			object.update();
		}
	}
	void display() {
		for (Object object : objects) {
			object.display();
		}
	}

	ArrayList<Object> objects;
};
