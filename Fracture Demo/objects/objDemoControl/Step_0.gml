
demo.Update();

if (demo != prevDemo) {
	prevDemo = demo;
	RefreshInterface();
}

if (FRACTURE_BENCHMARK and (tick++ mod 30 == 0)) {
	var _t = 0;
	with (__objFractureRenderer) {
		_t = __renderTime;
	}
	performanceNote = $" Rendered {instance_number(__objFracturePiece)} Pieces in {_t} ms.";
}

if (keyboard_check_pressed(ord("R"))) {
	room_restart();
}

if (keyboard_check_pressed(vk_f11)) {
	window_set_fullscreen(not window_get_fullscreen());
}
