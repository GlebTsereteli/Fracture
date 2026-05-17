
demo.Update();

if (demo != prevDemo) {
	prevDemo = demo;
	RefreshInterface();
}

if (keyboard_check_pressed(ord("E"))) {
	FractureBlast(mouse_x, mouse_y, 100, 2);
}

if (keyboard_check_pressed(ord("R"))) {
	room_restart();
}
