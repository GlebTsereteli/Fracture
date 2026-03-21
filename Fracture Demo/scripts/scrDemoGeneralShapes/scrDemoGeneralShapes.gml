
function DemoGeneralShape(_name) constructor {
	name = _name;
	
	static Update = Noop;
	static RefreshInterface = Noop;
}

function DemoGeneralCircle() : DemoGeneralShape("Circle") constructor {
	
}
function DemoGeneralConvexSprite() : DemoGeneralShape("Convex Sprite") constructor {
	
}
function DemoGeneralConcaveSprite() : DemoGeneralShape("Concave Sprite") constructor {
	
}
