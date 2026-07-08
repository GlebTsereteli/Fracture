// feather ignore all

/// @ignore
function __FractureLog(_message) {
	show_debug_message($"[{__FRACTURE_NAME}] {_message}.");
}

/// @ignore
function __FractureError(_message) {
	var _div = $"\n{string_repeat("—", 100)}\n";
	show_error($"\n{_div}[{string_upper(__FRACTURE_NAME)} {__FRACTURE_VERSION}] ERROR!\n{_message}.{_div}\n", true);
}
