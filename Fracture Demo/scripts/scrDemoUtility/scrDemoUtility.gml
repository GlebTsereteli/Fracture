
function Noop() {}

function Mod2(_dividend, _divisor) {
    return (_dividend - floor(_dividend / _divisor) * _divisor);
}

function DbgSelector(_name, _pool, _names) {
	with ({}) {
		scope = other;
		varName = string_lower(_name);
		pool = _pool;
		
		_names ??= array_map(pool, function(_thing) {
			return _thing.name;
		});
		dbg_drop_down(ref_create(scope, varName), pool, _names, _name);
		
		dbg_same_line();
		var _size = 19;
		dbg_button("-", function() {
			var _index = Mod2(array_get_index(pool, scope[$ varName]) - 1, array_length(pool));
			scope[$ varName] = pool[_index];
		}, _size, _size);
		dbg_same_line();
		dbg_button("+", function() {
			var _index = Mod2(array_get_index(pool, scope[$ varName]) + 1, array_length(pool));
			scope[$ varName] = pool[_index];
		}, _size, _size);
	}
}
