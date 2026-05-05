/// @desc Fade out & destroy.

if (FRACTURE_FADE_ENABLED) {
	if (phy_sleeping) {
		__settled = true;
	}
	if (not FRACTURE_FADE_SETTLED or __settled) {
		__fadeDelay--;
		if (__fadeDelay <= 0) {
			image_alpha -= __fadeSpeed;
			if (image_alpha <= 0) {
				var _index = array_get_index(__pack.__bodies, id);
				array_delete(__pack.__bodies, _index, 1);
				instance_destroy();
				if (array_length(__pack.__bodies) == 0) {
					instance_destroy(__pack);
				}
			}
		}
	}
}
