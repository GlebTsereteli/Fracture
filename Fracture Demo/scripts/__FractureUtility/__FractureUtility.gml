
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

function __FractureMatrixA() {
	__FRACTURE_MATRIX;
}
function __FractureMatrixB() {
	__FRACTURE_MATRIX;
}
function __FractureMatrixC() {
	__FRACTURE_MATRIX;
}
function __FractureMatrixIdentity() {
	__FRACTURE_MATRIX;
}
