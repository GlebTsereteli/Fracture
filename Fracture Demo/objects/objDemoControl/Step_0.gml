
if (keyboard_check_pressed(ord("1"))) {
	instance_create_depth(mouse_x, mouse_y, depth, objShape);
}
if (keyboard_check_pressed(ord("2"))) {
	var _shape = instance_position(mouse_x, mouse_y, objShape);
	if (_shape != noone) {
		var _t = get_timer();
		FractureVoronoi(_shape, 20);
		show_debug_message((get_timer() - _t) / 1000);
	}
}
if (keyboard_check_pressed(ord("3"))) {
	var _t = get_timer();
	with (objShape) {
		FractureVoronoi(id, 20);
	}
	show_debug_message((get_timer() - _t) / 1000);
}
if (keyboard_check_pressed(ord("4"))) {
	instance_destroy(objShape);
	instance_destroy(objFracturePack);
}
