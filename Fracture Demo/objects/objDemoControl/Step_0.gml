
if (type != prevType) {
	prevType = type;
	RefreshInterface();
}

if (keyboard_check_pressed(ord("1"))) {
	instance_create_depth(mouse_x, mouse_y, depth, objShape);
}
if (keyboard_check_pressed(ord("2"))) {
	var _shape = instance_position(mouse_x, mouse_y, objShape);
	if (_shape != noone) {
		Fracture(_shape);
	}
}
if (keyboard_check_pressed(ord("3"))) {
	FractureAll();
}
if (keyboard_check_pressed(ord("4"))) {
	DestroyAll();
	
}
