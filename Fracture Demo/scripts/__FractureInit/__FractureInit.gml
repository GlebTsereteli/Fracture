// feather ignore all

if (os_type == os_gxgames) {
	__FractureError("GX.games is not supported");
}
if (os_browser != browser_not_a_browser) {
	__FractureError("HTML5 is not supported");
}
__FractureLogBase($"You're using {__FRACTURE_NAME} {__FRACTURE_VERSION} ({__FRACTURE_DATE}) by Gleb Tsereteli");
