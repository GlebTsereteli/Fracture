// feather ignore all

function __FractureLog(_message) {
	show_debug_message($"[{__FRACTURE_NAME}] {_message}.");
}
function __FractureError(_message) {
	show_error($"[{__FRACTURE_NAME} {__FRACTURE_VERSION}] Error.\n-----------------------------------\n{_message}.\n\n", true);
}

function __FractureFormat() {
	static _format = (function() {
		vertex_format_begin();
		vertex_format_add_position();
		vertex_format_add_color();
		vertex_format_add_texcoord();
		return vertex_format_end();
	})();
	return _format;
}

function __FractureMatrix() {
	static _matrix = matrix_build_identity();
	return _matrix;
}
