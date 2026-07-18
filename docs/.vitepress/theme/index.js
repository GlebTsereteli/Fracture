import DefaultTheme from 'vitepress/theme'
import PatternRow from './components/PatternRow.vue'
import Video from './components/Video.vue'
import './custom.css'
import './colors.css'

export default {
  ...DefaultTheme,
  enhanceApp({ app }) {
    app.component('PatternRow', PatternRow)
    app.component('Video', Video)
  }
}