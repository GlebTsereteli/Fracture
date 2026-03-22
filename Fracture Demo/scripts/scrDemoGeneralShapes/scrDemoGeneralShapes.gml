
function DemoGeneralShape(_name) constructor {
	name = _name;
	object = asset_get_index($"objDemoShape{string_replace_all(name, " ", "")}");
	
	static Update = Noop;
	static RefreshInterface = Noop;
	static Fracture = Noop;
}

function DemoGeneralCircle() : DemoGeneralShape("Circle") constructor {
	
}
function DemoGeneralConvexSprite() : DemoGeneralShape("Convex Sprite") constructor {
	
}
function DemoGeneralConcaveSprite() : DemoGeneralShape("Concave Sprite") constructor {
	
}
