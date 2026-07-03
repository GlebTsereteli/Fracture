// feather ignore all
// Documentation: https://glebtsereteli.github.io/Fracture/pages/api/fracture/overview

/// Main Fracture interface. Manages Fracturing, Physics and Impulse Settings, and Rendering Layer/Depth.
/// Initialized internally, no additional setup required.
/// Call public methods using the Fracture.MethodName(<arguments>); syntax.
function Fracture() {
	#region Fracturing: Convex
	
	/// Fractures the given convex instance into a grid of Pieces clipped to the shape boundary, defined by the number of columns and rows.
	/// Optional noise offsets the grid vertices to produce more organic-looking pieces.
	/// The instance is destroyed automatically after fracturing.
	/// Returns an array of the created Piece instances.
	/// 
	/// @param {Id.Instance} inst The instance to fracture.
	/// @param {Real} shape The convex shape constant (FRACTURE_CONVEX_BOX, FRACTURE_CONVEX_CIRCLE, or FRACTURE_CONVEX_HULL).
	/// @param {Real} cols The number of columns.
	/// @param {Real} rows The number of rows.
	/// @param {Real} noiseX The horizontal grid noise intensity, from 0 to 1. [Default: 1]
	/// @param {Real} noiseY The vertical grid noise intensity, from 0 to 1. [Default: noiseX]
	/// 
	/// @return {Array<Id.Instance of __objFracturePiece>}
	/// @self Fracture
	static ConvexGrid = function(_inst, _shape, _cols, _rows, _noiseX = 1, _noiseY = _noiseX) {
		/*@ignore*/ static _funcs = [__FractureConvexGridBox, __FractureConvexGridCircle, __FractureConvexGridHull];
		
		__FRACTURE_VALIDATE_SHAPE;
		
		return _funcs[_shape](_inst, _cols, _rows, _noiseX, _noiseY);
	}
	
	/// Fractures the given convex instance into a brick pattern of Pieces clipped to the shape boundary, defined by the number of columns and rows.
	/// Horizontal layout offsets every other row, vertical layout offsets every other column.
	/// The instance is destroyed automatically after fracturing.
	/// Returns an array of the created Piece instances.
	/// 
	/// @param {Id.Instance} inst The instance to fracture.
	/// @param {Real} shape The convex shape constant (FRACTURE_CONVEX_BOX, FRACTURE_CONVEX_CIRCLE, or FRACTURE_CONVEX_HULL).
	/// @param {Real} cols The number of columns.
	/// @param {Real} rows The number of rows.
	/// @param {Bool} horizontal Whether bricks are laid horizontally (true) or vertically (false). [Default: true]
	/// 
	/// @return {Array<Id.Instance of __objFracturePiece>}
	/// @self Fracture
	static ConvexBrick = function(_inst, _shape, _cols, _rows, _horizontal = true) {
		/*@ignore*/ static _funcs = [__FractureConvexBrickBox, __FractureConvexBrickCircle, __FractureConvexBrickHull];
		
		__FRACTURE_VALIDATE_SHAPE;
		
		return _funcs[_shape](_inst, _cols, _rows, _horizontal);
	}
	
	/// Fractures the given convex instance into a diamond pattern of Pieces clipped to the shape boundary, defined by the number of columns and rows.
	/// The instance is destroyed automatically after fracturing.
	/// Returns an array of the created Piece instances.
	/// 
	/// @param {Id.Instance} inst The instance to fracture.
	/// @param {Real} shape The convex shape constant (FRACTURE_CONVEX_BOX, FRACTURE_CONVEX_CIRCLE, or FRACTURE_CONVEX_HULL).
	/// @param {Real} cols The number of columns.
	/// @param {Real} rows The number of rows.
	/// 
	/// @return {Array<Id.Instance of __objFracturePiece>}
	/// @self Fracture
	static ConvexDiamond = function(_inst, _shape, _cols, _rows) {
		/*@ignore*/ static _funcs = [__FractureConvexDiamondBox, __FractureConvexDiamondCircle, __FractureConvexDiamondHull];
		
		__FRACTURE_VALIDATE_SHAPE;
		
		return _funcs[_shape](_inst, _cols, _rows);
	}
	
	/// Fractures the given convex instance into a hexagonal pattern of Pieces clipped to the shape boundary, defined by the number of columns and rows.
	/// The instance is destroyed automatically after fracturing.
	/// Returns an array of the created Piece instances.
	/// 
	/// @param {Id.Instance} inst The instance to fracture.
	/// @param {Real} shape The convex shape constant (FRACTURE_CONVEX_BOX, FRACTURE_CONVEX_CIRCLE, or FRACTURE_CONVEX_HULL).
	/// @param {Real} cols The number of columns.
	/// @param {Real} rows The number of rows.
	/// @param {Bool} flat Whether hexagons are flat-topped (true) or pointy-topped (false). [Default: true]
	/// 
	/// @return {Array<Id.Instance of __objFracturePiece>}
	/// @self Fracture
	static ConvexHex = function(_inst, _shape, _cols, _rows, _flat = true) {
		/*@ignore*/ static _funcs = [__FractureConvexHexBox, __FractureConvexHexCircle, __FractureConvexHexHull];
		
		__FRACTURE_VALIDATE_SHAPE;
		
		return _funcs[_shape](_inst, _cols, _rows, _flat);
	}
	
	/// Fractures the given convex instance into a radial pattern of Pieces clipped to the shape boundary, defined by the number of Pieces.
	/// Optional noise varies the angular size of each Piece, and an optional point sets the radial origin.
	/// The instance is destroyed automatically after fracturing.
	/// Returns an array of the created Piece instances.
	/// 
	/// @param {Id.Instance} inst The instance to fracture.
	/// @param {Real} shape The convex shape constant (FRACTURE_CONVEX_BOX, FRACTURE_CONVEX_CIRCLE, or FRACTURE_CONVEX_HULL).
	/// @param {Real} pieceCount The number of Pieces.
	/// @param {Real} angleNoise The angular noise intensity, from 0 to 1. [Default: 0]
	/// @param {Real} originX The world-space x position of the radial origin. [Default: center]
	/// @param {Real} originY The world-space y position of the radial origin. [Default: center]
	/// 
	/// @return {Array<Id.Instance of __objFracturePiece>}
	/// @self Fracture
	static ConvexRadial = function(_inst, _shape, _pieceCount, _angleNoise = 0, _originX = undefined, _originY = undefined) {
		/*@ignore*/ static _funcs = [__FractureConvexRadialBox, __FractureConvexRadialCircle, __FractureConvexRadialHull];
		
		__FRACTURE_VALIDATE_SHAPE;
		
		return _funcs[_shape](_inst, _pieceCount, _angleNoise, _originX, _originY);
	}
	
	/// Fractures the given convex instance into a series of parallel slices clipped to the shape boundary, defined by the number of Pieces.
	/// A fixed angle produces consistent results, a random angle produces natural-looking variation.
	/// The instance is destroyed automatically after fracturing.
	/// Returns an array of the created Piece instances.
	/// 
	/// @param {Id.Instance} inst The instance to fracture.
	/// @param {Real} shape The convex shape constant (FRACTURE_CONVEX_BOX, FRACTURE_CONVEX_CIRCLE, or FRACTURE_CONVEX_HULL).
	/// @param {Real} pieceCount The number of Pieces.
	/// @param {Real} cutAngle The angle of the slice cuts in degrees. [Default: random(360)]
	/// 
	/// @return {Array<Id.Instance of __objFracturePiece>}
	/// @self Fracture
	static ConvexSlice = function(_inst, _shape, _pieceCount, _cutAngle = random(360)) {
		/*@ignore*/ static _funcs = [__FractureConvexSliceBox, __FractureConvexSliceCircle, __FractureConvexSliceHull];
		
		__FRACTURE_VALIDATE_SHAPE;
		
		return _funcs[_shape](_inst, _pieceCount, _cutAngle);
	}
	
	/// Fractures the given convex instance into a Voronoi pattern of Pieces clipped to the shape boundary, defined by the number of cells.
	/// Optional noise randomizes seed positions to produce more organic-looking pieces.
	/// The instance is destroyed automatically after fracturing.
	/// Returns an array of the created Piece instances.
	/// 
	/// @param {Id.Instance} inst The instance to fracture.
	/// @param {Real} shape The convex shape constant (FRACTURE_CONVEX_BOX, FRACTURE_CONVEX_CIRCLE, or FRACTURE_CONVEX_HULL).
	/// @param {Real} pieceCount The number of Voronoi cells.
	/// @param {Real} noise The seed noise intensity, from 0 to 1, where 0 produces a perfect grid and 1 is most organic. [Default: 1]
	/// 
	/// @return {Array<Id.Instance of __objFracturePiece>}
	/// @self Fracture
	static ConvexVoronoi = function(_inst, _shape, _pieceCount, _noise = 1) {
		/*@ignore*/ static _funcs = [__FractureConvexVoronoiBox, __FractureConvexVoronoiCircle, __FractureConvexVoronoiHull];
		
		__FRACTURE_VALIDATE_SHAPE;
		
		return _funcs[_shape](_inst, _pieceCount, _noise);
	}
	
	#endregion
	
	#region Settings: Physics
	
	/// Sets the physics properties applied to all future Fracture Pieces. Existing Pieces are not affected.
	/// Accepted fields: collisionGroup, density, restitution, friction, linearDamping, and angularDamping.
	/// Any omitted fields remain at their current values.
	/// If FRACTURE_AUTO_RESET is enabled, physics properties reset automatically after any core Fracture method.
	/// 
	/// @param {Struct} config The physics configuration struct for Fracture Pieces.
	/// 
	/// @return {Struct.Fracture}
	/// @self Fracture
	static Physics = function(_config) {
		with (__physics) {
			__collisionGroup = _config[$ "collisionGroup"] ?? __collisionGroup;
			__density = _config[$ "density"] ?? __density;
			__restitution = _config[$ "restitution"] ?? __restitution;
			__friction = _config[$ "friction"] ?? __friction;
			__linearDamping = _config[$ "linearDamping"] ?? __linearDamping;
			__angularDamping = _config[$ "angularDamping"] ?? __angularDamping;
		}
		
		return self;
	}
	
	/// Resets all Fracture physics properties to their default values. Existing Pieces are not affected.
	/// If FRACTURE_AUTO_RESET is enabled, this is called automatically after any core Fracture method.
	/// 
	/// @return {Struct.Fracture}
	/// @self Fracture
	static PhysicsReset = function() {
		with (__physics) {
			__collisionGroup = FRACTURE_DEFAULT_COLLISION_GROUP;
			__density = FRACTURE_DEFAULT_DENSITY;
			__restitution = FRACTURE_DEFAULT_RESTITUTION;
			__friction = FRACTURE_DEFAULT_FRICTION;
			__linearDamping = FRACTURE_DEFAULT_LINEAR_DAMPING;
			__angularDamping = FRACTURE_DEFAULT_ANGULAR_DAMPING;
		}
		
		return self;
	}
	
	#endregion
	#region Settings: Impulse
	
	/// Sets the impulse strength and origin applied to all future Fracture Pieces. Existing Pieces are not affected.
	/// If FRACTURE_AUTO_RESET is enabled, the impulse resets automatically after any core Fracture method.
	/// 
	/// @param {Real} strength The strength of the impulse applied to Fracture Pieces.
	/// @param {Real} x The world x position of the impulse origin. [Default: center]
	/// @param {Real} y The world y position of the impulse origin. [Default: center]
	/// 
	/// @return {Struct.Fracture}
	/// @self Fracture
	static Impulse = function(_strength, _x = undefined, _y = undefined) {
		with (__impulse) {
			__strength = _strength;
			__x = _x;
			__y = _y;
		}
		
		return self;
	}
	
	/// Resets the impulse strength and origin to their default values. Existing Pieces are not affected.
	/// If FRACTURE_AUTO_RESET is enabled, this is called automatically after any core Fracture method.
	/// 
	/// @return {Struct.Fracture}
	/// @self Fracture
	static ImpulseReset = function() {
		with (__impulse) {
			__strength = FRACTURE_DEFAULT_IMPULSE_STRENGTH;
			__x = undefined;
			__y = undefined;
		}
		
		return self;
	}
	
	#endregion
	#region Settings: Rendering
	
	/// Sets the layer to render all Fracture Pieces on.
	/// All Fracture Pieces share a single layer.
	/// 
	/// @param {Id.Layer,String} layer The layer ID or name to render all Fracture Pieces on.
	/// 
	/// @return {Struct.Fracture}
	/// @self Fracture
	static Layer = function(_layer) {
		__FRACTURE_CATCH_RENDERER;
		__objFractureRenderer.layer = _layer;
		
		return self;
	}
	
	/// Sets the depth to render all Fracture Pieces at.
	/// All Fracture Pieces share a single depth.
	/// 
	/// @param {Real} depth The depth value to render all Fracture Pieces at.
	/// 
	/// @return {Struct.Fracture}
	/// @self Fracture
	static Depth = function(_depth) {
		__FRACTURE_CATCH_RENDERER;
		__objFractureRenderer.depth = _depth;
		
		return self;
	}
	
	#endregion
	
	#region Lifecycle
	
	/// Destroys all existing Fracture Pieces immediately.
	/// 
	/// @return {Struct.Fracture}
	/// @self Fracture
	static Clear = function() {
		instance_destroy(__objFracturePiece);
		
		return self;
	}
	
	/// Begins fading out all existing Fracture Pieces immediately.
	/// Requires FRACTURE_FADE_ENABLED to be true.
	/// 
	/// @return {Struct.Fracture}
	/// @self Fracture
	static Fade = function() {
		if (not FRACTURE_FADE_ENABLED) {
			__FractureError("Fade(): FRACTURE_FADE_ENABLED must be enabled to fade Pieces");
		}
		
		with (__objFracturePiece) {
			__settled = true;
			__fadeDelay = 0;
		}
		
		return self;
	}
	
	/// Pauses fade processing on all existing Fracture Pieces.
	/// Does not pause the physics world itself, which remains under your control.
	/// Pair with 'physics_pause_enable(true)' to completely freeze Pieces.
	/// 
	/// @return {Struct.Fracture}
	/// @self Fracture
	static Pause = function() {
		with (__objFracturePiece) {
			__paused = true;
		}
		
		return self;
	}
	
	/// Resumes fade processing on all paused Fracture Pieces.
	/// Pair with 'physics_pause_enable(false)' to resume physics simulation.
	/// 
	/// @return {Struct.Fracture}
	/// @self Fracture
	static Resume = function() {
		with (__objFracturePiece) {
			__paused = false;
		}
		
		return self;
	}
	
	#endregion
	
	#region __private
	
	/// @ignore
	static __format = (function() {
		vertex_format_begin();
		vertex_format_add_position();
		vertex_format_add_color();
		vertex_format_add_texcoord();
		return vertex_format_end();
	})();
	
	/// @ignore
	static __physics = {
		__collisionGroup: FRACTURE_DEFAULT_COLLISION_GROUP,
		__density: FRACTURE_DEFAULT_DENSITY,
		__restitution: FRACTURE_DEFAULT_RESTITUTION,
		__friction: FRACTURE_DEFAULT_FRICTION,
		__linearDamping: FRACTURE_DEFAULT_LINEAR_DAMPING,
		__angularDamping: FRACTURE_DEFAULT_ANGULAR_DAMPING,
	};
	
	/// @ignore
	static __impulse = {
		__strength: FRACTURE_DEFAULT_IMPULSE_STRENGTH,
		__x: undefined,
		__y: undefined,
	};
	
	#endregion
}
