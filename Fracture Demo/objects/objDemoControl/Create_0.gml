
event_user(0);

demos = [
	new DemoGeneral(),
	new DemoShowcase(),
];
demo = array_first(demos);
prevDemo = demo;

// Debug
outlines = false;
coms = false;
shapes = false;

edgeFixture = undefined;
view = undefined;
convexPoints = {
	sprDemoShapeConvex01: [36, -120, 84, -95, 121, -31, 0, 121, -120, -31, -84, -96, -37, -120],
	sprDemoShapeConvex02: [0, -120, 120, -78, 120, 78, 0, 120, -120, 78, -120, -78],
	sprDemoShapeConvex03: [0, -120, 120, -30, 60, 120, -60, 120, -120, -30],
};

RefreshInterface();
