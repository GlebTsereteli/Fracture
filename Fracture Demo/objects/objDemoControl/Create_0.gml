
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
	sprDemoShapeConvex02: [-2, -120, 120, -76, 120, 76, -2, 120, -120, 78, -120, -76],
	sprDemoShapeConvex03: [2, -121, 120, -30, 63, 120, -60, 120, -120, -30],
};

RefreshInterface();
