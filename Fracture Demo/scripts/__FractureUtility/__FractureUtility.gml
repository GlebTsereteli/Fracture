
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
	static _matrixA = matrix_build_identity();
	return _matrixA;
}
function __FractureMatrixB() {
	static _matrixB = matrix_build_identity();
	return _matrixB;
}
function __FractureMatrixC() {
	static _matrixC = matrix_build_identity();
	return _matrixC;
}
function __FractureMatrixIdentity() {
	static _matrixIdentity = matrix_build_identity();
	return _matrixIdentity;
}
