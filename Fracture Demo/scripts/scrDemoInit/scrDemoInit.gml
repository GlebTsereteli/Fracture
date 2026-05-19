
function DemoInit() {
	randomize();
	texture_prefetch("Default");
	
	FractureDepth(-10000);
	instance_create_depth(0, 0, -15000, objDemoControl);
}
