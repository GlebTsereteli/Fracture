/// @desc Fade out & destroy

if (__paused) exit;
if (__fadeSpeed == 0) exit;

if (phy_sleeping) {
	__settled = true;
}

if (not __afterSettle or __settled) {
	__fadeDelay--;
	if (__fadeDelay <= 0) {
		image_alpha -= __fadeSpeed;
		if (image_alpha <= 0) {
			instance_destroy();
		}
	}
}
