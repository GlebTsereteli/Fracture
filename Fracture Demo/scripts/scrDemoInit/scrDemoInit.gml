
function DemoInit() {
	randomize();
	texture_prefetch("default");
	
	instance_create_depth(0, 0, -15000, objDemoControl);
	
	room_goto(rmDemo);
}
