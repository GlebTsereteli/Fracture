/// @desc Initialize singleton.

if (instance_number(object_index) > 1) {
	instance_destroy();
	exit;
}

__shader = __shdFracture;
__uAlpha = shader_get_uniform(__shader, "uAlpha");
