
event_user(0);

// type
types = [
	new DemoTypeGrid(),
	new DemoTypeZigzag(),
	new DemoTypeBrick(),
	new DemoTypeVoronoi(),
];
type = array_first(types);
prevType = type;

// debug
outlines = false;
coms = false;
shapes = false;
aabb = false;

view = undefined;
RefreshInterface();
