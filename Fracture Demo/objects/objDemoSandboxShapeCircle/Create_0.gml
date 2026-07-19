event_inherited();

var _fx = physics_fixture_create(); {
	var _radius = sprite_height / 2
	
	physics_fixture_set_collision_group(_fx, FRACTURE_DEFAULT_COLLISION_GROUP);
	physics_fixture_set_circle_shape(_fx, _radius);
	physics_fixture_set_density(_fx, 0.5);
	physics_fixture_set_restitution(_fx, 0.5);
	
	var _offsetX = _radius - sprite_xoffset;
	var _offsetY = _radius - sprite_yoffset;
	fixture = physics_fixture_bind_ext(_fx, id, _offsetX, _offsetY);
	physics_fixture_delete(_fx);
}
