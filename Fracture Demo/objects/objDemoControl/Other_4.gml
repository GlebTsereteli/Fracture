
if (edgeFixture != undefined) {
	physics_fixture_delete(edgeFixture);
}

var _fx = physics_fixture_create();
physics_fixture_set_collision_group(_fx, FRACTURE_COLLISION_GROUP);
physics_fixture_set_density(_fx, 0);
physics_fixture_set_chain_shape(_fx, true);
physics_fixture_add_point(_fx, 1, 1);
physics_fixture_add_point(_fx, room_width, 1);
physics_fixture_add_point(_fx, room_width, room_height);
physics_fixture_add_point(_fx, 1, room_height);
edgeFixture = physics_fixture_bind(_fx, id);
physics_fixture_delete(_fx);
