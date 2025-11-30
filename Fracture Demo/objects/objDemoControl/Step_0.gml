
if (keyboard_check_pressed(vk_space)) {
	grid.Generate();
}
if (mouse_check_button_pressed(mb_left)) {
	instance_create_depth(mouse_x, mouse_y, depth, objShape);
}
