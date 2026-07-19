// feather ignore all
// Documentation: https://glebtsereteli.github.io/Fracture/pages/api/fracture/overview

/// Main Fracture interface. Manages Fracturing, per-fracture and global Settings, and Piece Lifecycle.
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
	/// @return {Array<Id.Instance of __FracturePiece>}
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
	/// @return {Array<Id.Instance of __FracturePiece>}
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
	/// @return {Array<Id.Instance of __FracturePiece>}
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
	/// @return {Array<Id.Instance of __FracturePiece>}
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
	/// @return {Array<Id.Instance of __FracturePiece>}
	/// @self Fracture
	static ConvexRadial = function(_inst, _shape, _pieceCount, _angleNoise = 0, _originX = undefined, _originY = undefined) {
		/*@ignore*/ static _funcs = [__FractureConvexRadialBox, __FractureConvexRadialCircle, __FractureConvexRadialHull];
		
		__FRACTURE_VALIDATE_SHAPE;
		return _funcs[_shape](_inst, _pieceCount, _angleNoise, _originX, _originY);
	}
	
	/// Fractures the given convex instance into a series of parallel slices clipped to the shape boundary, defined by the number of Pieces.
	/// A fixed angle produces consistent results, a random angle produces natural-looking variation.
	/// Angles follow GameMaker's convention: '0' points right, increasing counter-clockwise.
	/// The instance is destroyed automatically after fracturing.
	/// Returns an array of the created Piece instances.
	/// 
	/// @param {Id.Instance} inst The instance to fracture.
	/// @param {Real} shape The convex shape constant (FRACTURE_CONVEX_BOX, FRACTURE_CONVEX_CIRCLE, or FRACTURE_CONVEX_HULL).
	/// @param {Real} pieceCount The number of Pieces.
	/// @param {Real} cutAngle The angle of the slice cuts in degrees. [Default: random(360)]
	/// 
	/// @return {Array<Id.Instance of __FracturePiece>}
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
	/// @return {Array<Id.Instance of __FracturePiece>}
	/// @self Fracture
	static ConvexVoronoi = function(_inst, _shape, _pieceCount, _noise = 1) {
		/*@ignore*/ static _funcs = [__FractureConvexVoronoiBox, __FractureConvexVoronoiCircle, __FractureConvexVoronoiHull];
		
		__FRACTURE_VALIDATE_SHAPE;
		return _funcs[_shape](_inst, _pieceCount, _noise);
	}
	
	#endregion
	
	#region Settings: Per-Fracture
	
	/// Sets the physics properties applied to the next fracture call. Existing Pieces are not affected.
	/// ---
	/// Supported config fields:
	/// - collisionGroup: The Piece fixture collision group.
	/// - density: The Piece fixture density.
	/// - restitution: The Piece fixture restitution.
	/// - friction: The Piece fixture friction.
	/// - linearDamping: The Piece fixture linear damping.
	/// - angularDamping: The Piece fixture angular damping.
	/// ---
	/// Defaults for each field come from the matching FRACTURE_DEFAULT_* macro under Defaults: Physics in FractureConfig.
	/// Any omitted fields remain at their current values.
	/// Physics properties reset after the next fracturing call.
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
	
	/// Sets the mass applied to the next fracture call. Existing Pieces are not affected.
	/// Overrides the density-derived mass, so every Piece gets the same mass regardless of its size.
	/// Mass resets after the next fracturing call.
	/// 
	/// @param {Real} mass The mass applied to each Fracture Piece, or undefined to derive it from density and area.
	/// 
	/// @return {Struct.Fracture}
	/// @self Fracture
	static Mass = function(_mass) {
		__physics.__mass = _mass;
		
		return self;
	}
	
	/// Sets the impulse strength and origin applied to the next fracture call. Existing Pieces are not affected.
	/// Impulse settings reset after the next fracturing call.
	/// 
	/// @param {Real} strength The strength of the impulse applied to Fracture Pieces.
	/// @param {Real} x The world-space x position of the impulse origin. [Default: center]
	/// @param {Real} y The world-space y position of the impulse origin. [Default: center]
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
	
	/// Sets the fade behavior applied to the next fracture call. Existing Pieces are not affected.
	/// ---
	/// Supported config fields:
	/// - afterSettle: Begin fading only once a Piece has come to rest (true) or immediately after its delay (false).
	/// - delay: Sets both delayFrom and delayTo to a single value.
	/// - delayFrom: Minimum random delay in steps before a Piece begins fading.
	/// - delayTo: Maximum random delay in steps before a Piece begins fading.
	/// - speed: Sets both speedFrom and speedTo to a single value.
	/// - speedFrom: Minimum random alpha decrease per step while a Piece fades.
	/// - speedTo: Maximum random alpha decrease per step while a Piece fades.
	/// ---
	/// Explicit delayFrom/delayTo and speedFrom/speedTo take precedence over delay/speed.
	/// Defaults for each field come from the matching FRACTURE_DEFAULT_* macro under Defaults: Fade in FractureConfig.
	/// Any omitted fields remain at their current values.
	/// Fade settings reset after the next fracturing call.
	/// 
	/// @param {Struct} config The fade configuration struct for Fracture Pieces.
	/// 
	/// @return {Struct.Fracture}
	/// @self Fracture
	static Fade = function(_config) {
		with (__fade) {
			__afterSettle = _config[$ "afterSettle"] ?? __afterSettle;
			
			var _delay = _config[$ "delay"];
			__delayFrom = _config[$ "delayFrom"] ?? _delay ?? __delayFrom;
			__delayTo = _config[$ "delayTo"] ?? _delay ?? __delayTo;
			
			var _speed = _config[$ "speed"];
			__speedFrom = _config[$ "speedFrom"] ?? _speed ?? __speedFrom;
			__speedTo = _config[$ "speedTo"] ?? _speed ?? __speedTo;
		}
		
		return self;
	}
	
	#endregion
	#region Settings: Global
	
	/// Sets the layer or depth to render all Fracture Pieces on.
	/// Pass a real for a depth, or a layer ID or name for a layer.
	/// All Fracture Pieces share a single layer/depth.
	/// Unlike per-fracture settings, this persists until changed again.
	/// 
	/// @param {Real,Id.Layer,String} layerOrDepth The depth value, or the layer ID or name, to render all Fracture Pieces on.
	/// 
	/// @return {Struct.Fracture}
	/// @self Fracture
	static RenderAt = function(_layerOrDepth) {
		__FRACTURE_CATCH_RENDERER;
		
		if (is_real(_layerOrDepth)) {
			__FractureRenderer.depth = _layerOrDepth;
		}
		else if (is_string(_layerOrDepth) or is_handle(_layerOrDepth)) {
			__FractureRenderer.layer = _layerOrDepth;
		}
		else {
			__FractureError($"Could not render Pieces at layer or depth <{_layerOrDepth}>.\nExpected <Real, String or Id.Layer>, got <{typeof(_layerOrDepth)}>");
		}
		
		return self;
	}
	
	#endregion
	
	#region Lifecycle
	
	/// Destroys all existing Fracture Pieces immediately.
	/// 
	/// @return {Struct.Fracture}
	/// @self Fracture
	static Clear = function() {
		instance_destroy(__FracturePiece);
		
		return self;
	}
	
	/// Begins fading out all existing Fracture Pieces immediately.
	/// Pieces with a fade speed of 0 have no fade rate, so their Step processing exits early and they are left unchanged.
	/// 
	/// @return {Struct.Fracture}
	/// @self Fracture
	static ForceFade = function() {
		with (__FracturePiece) {
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
		with (__FracturePiece) {
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
		with (__FracturePiece) {
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
		__mass: undefined,
	};
	
	/// @ignore
	static __impulse = {
		__strength: FRACTURE_DEFAULT_IMPULSE_STRENGTH,
		__x: undefined,
		__y: undefined,
	};
	
	/// @ignore
	static __fade = {
		__afterSettle: FRACTURE_DEFAULT_FADE_AFTER_SETTLE,
		__delayFrom: FRACTURE_DEFAULT_FADE_DELAY_FROM,
		__delayTo: FRACTURE_DEFAULT_FADE_DELAY_TO,
		__speedFrom: FRACTURE_DEFAULT_FADE_SPEED_FROM,
		__speedTo: FRACTURE_DEFAULT_FADE_SPEED_TO,
	};
	
	/// @ignore
	static __ResetSettings = function() {
		with (__physics) {
			__collisionGroup = FRACTURE_DEFAULT_COLLISION_GROUP;
			__density = FRACTURE_DEFAULT_DENSITY;
			__restitution = FRACTURE_DEFAULT_RESTITUTION;
			__friction = FRACTURE_DEFAULT_FRICTION;
			__linearDamping = FRACTURE_DEFAULT_LINEAR_DAMPING;
			__angularDamping = FRACTURE_DEFAULT_ANGULAR_DAMPING;
			__mass = undefined;
		}
		with (__impulse) {
			__strength = FRACTURE_DEFAULT_IMPULSE_STRENGTH;
			__x = undefined;
			__y = undefined;
		}
		with (__fade) {
			__afterSettle = FRACTURE_DEFAULT_FADE_AFTER_SETTLE;
			__delayFrom = FRACTURE_DEFAULT_FADE_DELAY_FROM;
			__delayTo = FRACTURE_DEFAULT_FADE_DELAY_TO;
			__speedFrom = FRACTURE_DEFAULT_FADE_SPEED_FROM;
			__speedTo = FRACTURE_DEFAULT_FADE_SPEED_TO;
		}
	};
	
	#endregion
}
