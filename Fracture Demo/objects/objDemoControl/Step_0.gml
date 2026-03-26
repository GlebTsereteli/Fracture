
demo.Update();

if (demo != prevDemo) {
	prevDemo = demo;
	RefreshInterface();
}

if (keyboard_check_pressed(ord("R"))) {
	instance_destroy(__objFractureBody)
}
