<script setup>
import { withBase } from 'vitepress'
import { ref, onMounted, onBeforeUnmount } from 'vue'

defineProps({
  pattern: {
    type: String,
    required: true
  }
})

const shapes = ["Box", "Circle", "Hull"]
const videoRefs = ref([])
let observer = null

onMounted(() => {
  observer = new IntersectionObserver((entries) => {
    for (const entry of entries) {
      const video = entry.target
      if (entry.isIntersecting) {
        if (!video.src) {
          video.src = video.dataset.src
        }
        video.play().catch(() => {})
      }
      else {
        video.pause()
      }
    }
  }, { rootMargin: "200px", threshold: 0.1 })

  for (const video of videoRefs.value) {
    observer.observe(video)
  }
})

onBeforeUnmount(() => {
  if (observer) {
    observer.disconnect()
  }
})
</script>

<template>
  <div class="pattern-row">
    <div v-for="shape in shapes" :key="shape" class="pattern-cell">
      <video
        ref="videoRefs"
        :data-src="withBase(`/patterns/${pattern}${shape}.mp4`)"
        loop
        muted
        playsinline
        preload="none"
      ></video>
      <span class="pattern-label">{{ shape }}</span>
    </div>
  </div>
</template>

<style scoped>
.pattern-row {
  display: flex;
  gap: 12px;
}
.pattern-cell {
  flex: 1;
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 6px;
}
.pattern-cell video {
  width: 100%;
  border: 2px solid var(--vp-c-divider);
  border-radius: 10px;
  background: #0a0a0a;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12);
}
.pattern-label {
  text-align: center;
  font-size: 0.8em;
  font-weight: 600;
  letter-spacing: 0.05em;
  text-transform: uppercase;
  color: var(--vp-c-text-2);
}
</style>