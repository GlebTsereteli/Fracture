
function DemoFade() constructor {
	settings = {
		afterSettle: FRACTURE_DEFAULT_FADE_AFTER_SETTLE,
		delayFrom: FRACTURE_DEFAULT_FADE_DELAY_FROM,
		delayTo: FRACTURE_DEFAULT_FADE_DELAY_TO,
		speedFrom: FRACTURE_DEFAULT_FADE_SPEED_FROM,
		speedTo: FRACTURE_DEFAULT_FADE_SPEED_TO,
	};
	
	static Set = function() {
		Fracture.Fade(settings);
	};
	static RefreshInterface = function() {
		dbg_section("Fade");
		
		dbg_checkbox(ref_create(settings, "afterSettle"), "After Settle");
		dbg_slider_int(ref_create(settings, "delayFrom"), 0, 120, "Delay From", 1);
		dbg_slider_int(ref_create(settings, "delayTo"), 0, 120, "Delay To", 1);
		dbg_slider(ref_create(settings, "speedFrom"), 0, 0.1, "Speed From", 0.005);
		dbg_slider(ref_create(settings, "speedTo"), 0, 0.1, "Speed To", 0.005);
	};
}
