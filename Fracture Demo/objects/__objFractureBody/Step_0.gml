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
				instance_destroy();
			}
		}
	}
}
