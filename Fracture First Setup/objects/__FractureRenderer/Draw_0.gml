/// @desc Render pieces

if (FRACTURE_BENCHMARK) {
	__FRACTURE_BENCH_START;
}

__FractureRender();

if (FRACTURE_BENCHMARK) {
	__renderTime = __FRACTURE_BENCH_END;
}
