import DefaultTheme from 'vitepress/theme'
import ShapeRow from './components/ShapeRow.vue'
import './custom.css'
import './colors.css'

export default {
  ...DefaultTheme,
  enhanceApp({ app }) {
    app.component('ShapeRow', ShapeRow)
  }
}