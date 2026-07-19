/// @desc Fracture with impulse and random pattern

Fracture.Impulse(1.5, mouse_x, mouse_y);

switch (irandom(2)) {
	case 0: Fracture.ConvexGrid(id, FRACTURE_CONVEX_BOX, 4, 4); break;
	case 1: Fracture.ConvexRadial(id, FRACTURE_CONVEX_BOX, 8, 0.5, mouse_x, mouse_y); break;
	case 2: Fracture.ConvexVoronoi(id, FRACTURE_CONVEX_BOX, 10); break;
}
