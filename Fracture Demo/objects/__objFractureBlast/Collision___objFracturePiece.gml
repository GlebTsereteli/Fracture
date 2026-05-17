/// @desc Blast pieces

var _dir = point_direction(phy_position_x, phy_position_y, other.phy_position_x, other.phy_position_y);
with (other) {
    physics_apply_impulse(phy_position_x, phy_position_y,
        lengthdir_x(other.__force, _dir),
        lengthdir_y(other.__force, _dir)
    );
}
