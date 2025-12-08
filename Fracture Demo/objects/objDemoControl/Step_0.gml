
if (keyboard_check_pressed(vk_space)) {
	grid.Generate();
}
if (keyboard_check_pressed(ord("1"))) {
	instance_create_depth(mouse_x, mouse_y, depth, objShape);
}
if (keyboard_check_pressed(ord("2"))) {
	var _shape = instance_position(mouse_x, mouse_y, objShape);
	if (_shape != noone) {
		var _t = get_timer();
		FractureGrid(_shape);
		show_debug_message((get_timer() - _t) / 1000);
	}
}
if (keyboard_check_pressed(ord("3"))) {
	with (instance_destroy(objShape)) {
		FractureGrid(id);
	}
}
if (keyboard_check_pressed(ord("4"))) {
	instance_destroy(objShape);
	instance_destroy(__objFracturePieceGroup);
}
