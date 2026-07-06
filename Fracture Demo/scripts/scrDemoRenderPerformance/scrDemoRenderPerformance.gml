
function DemoRenderPerformance() constructor {
	text = "";
	tick = 0;
	interval = 30;
	
	Update = function() {
		if (not FRACTURE_BENCHMARK) return;
		if ((tick++ mod interval) != 0) return;
		
		var _time = 0;
		with (__objFractureRenderer) {
			_time = __renderTime;
		}
		
		text = $" Rendered {instance_number(__objFracturePiece)} Pieces in {_time} ms.";
	};
	RefreshInterface = function() {
		if (FRACTURE_BENCHMARK) {
			dbg_text_separator("Render Performance");
			dbg_text(ref_create(self, "text"));
		}
	};
}
