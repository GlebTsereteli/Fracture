
if (FRACTURE_FADE_ENABLED) {
	__fadeDelay = irandom_range(FRACTURE_FADE_DELAY_FROM, FRACTURE_FADE_DELAY_TO);
	__fadeSpeed = random_range(FRACTURE_FADE_SPEED_FROM, FRACTURE_FADE_SPEED_TO);
	__settled = false;
}
