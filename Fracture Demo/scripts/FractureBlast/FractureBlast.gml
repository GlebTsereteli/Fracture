// feather ignore all

/// @func FractureBlast()
/// 
/// @param {Real} x The x position of the blast.
/// @param {Real} y The y position of the blast.
/// @param {Real} radius The radius of the blast area.
/// @param {Real} force The impulse force applied to each affected Piece. Passing a negative value pulls pieces towards the blast position.
/// 
/// @desc Applies an impulse to all Fracture Pieces within the given radius. Positive force pushes pieces away, negative force pulls them in.
function FractureBlast(_x, _y, _radius, _force) {
	static _tempFx = (function() {
		var _fx = physics_fixture_create();
		physics_fixture_set_sensor(_fx, true);
		return _fx;
	})();
	static _params = __FractureParams();
	
	with (instance_create_depth(_x, _y, 0, __objFractureBlast)) {
		physics_fixture_set_circle_shape(_tempFx, _radius);
		physics_fixture_set_collision_group(_tempFx, _params.__collisionGroup);
		__fixture = physics_fixture_bind(_tempFx, id);
		__force = _force;
	}
}
