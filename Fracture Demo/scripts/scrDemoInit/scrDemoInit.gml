
function DemoInit() {
	randomize();
	window_enable_borderless_fullscreen(true);
	texture_prefetch("Default");
	
	Fracture.RenderAt(-10000);
	instance_create_depth(0, 0, -15000, objDemoControl);
}
