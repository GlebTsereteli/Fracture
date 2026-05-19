
function DemoSandboxShapeConvex() : DemoSandboxShape("Convex") constructor {
	patterns = [
		new DemoSandboxPatternGrid(),
		new DemoSandboxPatternBrick(),
		new DemoSandboxPatternDiamond(),
		new DemoSandboxPatternHex(),
		new DemoSandboxPatternRadial(),
		new DemoSandboxPatternSlice(),
		new DemoSandboxPatternVoronoi(),
	];
}
