
event_user(0);

demos = [
	new DemoGeneral(),
	new DemoShowcase(),
];
demo = array_first(demos);
prevDemo = demo;

// debug
outlines = false;
coms = false;
shapes = false;
aabb = false;

edgeFixture = undefined;
view = undefined;

RefreshInterface();
