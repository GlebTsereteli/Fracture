
function DemoSandboxShapeCircle() : DemoSandboxShape("Circle") constructor {
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
