<script setup>
defineProps({
	pattern: {
		type: String,
		required: true
	}
})

const shapes = ["box", "circle", "hull"]
</script>

<template>
	<div class="shape-row">
		<img
			v-for="shape in shapes"
			:key="shape"
			src="/patterns/test.gif"
			:alt="shape"
		/>
		<!-- <img
			v-for="shape in shapes"
			:key="shape"
			:src="`/patterns/${pattern}${shape.charAt(0).toUpperCase() + shape.slice(1)}.gif`"
			:alt="shape"
		/> -->
	</div>
	<div class="shape-labels">
		<span v-for="shape in shapes" :key="shape">
			<a :href="`#${shape}`">{{ shape.charAt(0).toUpperCase() + shape.slice(1) }}</a>
		</span>
	</div>
</template>

<style scoped>
.shape-row {
	display: flex;
	gap: 4px;
}
.shape-row img {
	width: 33.333%;
	border-radius: 8px;
}
.shape-labels {
	display: flex;
	gap: 4px;
	text-align: center;
}
.shape-labels span {
	width: 33.333%;
}
</style>