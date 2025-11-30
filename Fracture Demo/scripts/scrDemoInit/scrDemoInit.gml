
function DemoInit() {
	randomize();
	
	instance_create_depth(0, 0, -15000, objDemoControl);
	
	room_goto(rmDemo);
}
