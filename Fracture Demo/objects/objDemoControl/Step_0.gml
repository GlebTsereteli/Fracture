
demo.Update();

if (demo != prevDemo) {
	prevDemo = demo;
	RefreshInterface();
}

renderPerformance.Update();

if (keyboard_check_pressed(ord("R"))) {
	room_restart();
}

if (keyboard_check_pressed(vk_f11)) {
	window_set_fullscreen(not window_get_fullscreen());
}
