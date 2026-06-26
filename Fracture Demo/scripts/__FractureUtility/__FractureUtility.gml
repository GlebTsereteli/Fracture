// feather ignore all

/// @ignore
function __FractureLog(_message) {
	show_debug_message($"[{__FRACTURE_NAME}] {_message}.");
}

/// @ignore
function __FractureError(_message) {
	show_error($"[{__FRACTURE_NAME} {__FRACTURE_VERSION}] Error.\n-----------------------------------\n{_message}.\n\n", true);
}
