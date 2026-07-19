
event_user(0);

demos = [
	new DemoSandbox(),
	new DemoWalls(),
];
demo = array_first(demos);
prevDemo = demo;

// Debug
edgeFixture = undefined;
view = undefined;

outlines = false;
coms = false;
shapes = false;

renderPerformance = new DemoRenderPerformance();

RefreshInterface();