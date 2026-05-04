
function DemoInit() {
	randomize();
	texture_prefetch("Default");
	instance_create_depth(0, 0, -15000, objDemoControl);
}
