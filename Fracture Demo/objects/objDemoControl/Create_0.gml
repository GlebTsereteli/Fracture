
event_user(0);

demos = [
	new DemoSandbox(),
	new DemoWalls(),
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
	sprDemoSandboxShapeConvex01: [36, -120, 84, -95, 121, -31, 0, 121, -120, -31, -84, -96, -37, -120],
	sprDemoSandboxShapeConvex02: [-2, -120, 120, -76, 120, 76, -2, 120, -120, 78, -120, -76],
	sprDemoSandboxShapeConvex03: [2, -121, 120, -30, 63, 120, -60, 120, -120, -30],
	sprDemoSandboxShapeConvex04: [-60, -120, 60, -120, 89, -90, 89, 90, 60, 121, -60, 121, -90, 90, -90, -90],
};

FractureDepth(-1000);
RefreshInterface();
