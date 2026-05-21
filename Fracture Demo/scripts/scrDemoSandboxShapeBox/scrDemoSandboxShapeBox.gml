
function DemoSandboxShapeBox() : DemoSandboxShape("Box") constructor {
	patterns = [
		new DemoSandboxPatternGrid(),
		new DemoSandboxPatternBrick(),
		new DemoSandboxPatternDiamond(),
		new DemoSandboxPatternHex(),
		new DemoSandboxPatternRadial(),
		new DemoSandboxPatternSlice(),
		new DemoSandboxPatternVoronoi(),
		new DemoSandboxPatternCut(),
	];
}
