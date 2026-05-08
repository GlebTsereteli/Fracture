// feather ignore all

/// @func FractureLayer()
/// @param {Id.Layer,String} layer The layer ID or name to render all Fracture pieces on.
/// 
/// @desc Sets the layer to render all Fracture pieces on.
/// 
/// NOTE: All Fracture pieces share a single layer.
function FractureLayer(_layer) {
	__FRACTURE_CATCH_RENDERER;
	__objFractureRenderer.layer = _layer;
}

/// @func FractureDepth()
/// @param {Real} depth The depth value to render all Fracture pieces at.
/// 
/// @desc Sets the depth to render all Fracture pieces at.
/// 
/// NOTE: All Fracture pieces share a single depth.
function FractureDepth(_depth) {
	__FRACTURE_CATCH_RENDERER;
	__objFractureRenderer.depth = _depth;
}
