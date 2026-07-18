<script setup lang="ts">
import { withBase } from 'vitepress'

defineProps<{
	src: string
}>()
</script>

<template>
	<video class="fracture-video" controls :src="withBase(src)"></video>
</template>

<style scoped>
.fracture-video {
	width: 100%;
	border: 2px solid var(--vp-c-divider);
	border-radius: 10px;
	background: #0a0a0a;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12);
	margin-top: 1rem;
}
</style>