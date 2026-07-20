---
layout: home

hero:
  name: Fracture
  text: Physics destruction for GameMaker
  tagline: Fracture objects into procedural Box2D physics pieces using a variety of shapes and patterns.
  actions:
    - theme: brand
      text: What is Fracture?
      link: '/home/whatIsIt/whatIsIt'
    - theme: alt
      text: Get Started
      link: '/home/gettingStarted'
  image:
    src: /logoBig.png
    alt: Icon

features:
  - title: 💥 Drop-In Destruction
    details: Fracture any instance into physics pieces in one function call. Geometry, rendering, and piece lifecycle are handled automatically.
  - title: 🧩 Shapes & Patterns
    details: Fracture any instance as a Box, Circle, or convex Hull across several patterns - Grid, Brick, Diamond, Hex, Radial, Slice, and Voronoi.
  - title: ⚡ Efficient Rendering
    details: Every fracture bakes a single frozen vertex buffer shared across all its pieces. No surfaces, no sprite baking, no live primitive drawing.
  - title: 🌫️ Automatic Fading
    details: Pieces fade out and destroy themselves once they settle. Delay, speed, and settle behavior are all configurable.
  - title: 🎯 Impulse Control
    details: Trigger an outward impulse through every piece on fracture, from any origin point. Tune it from a gentle nudge to an explosive shatter.
  - title: 🔧 Configurable Physics
    details: Set density/restitution/friction/damping/mass for all pieces through a chainable call. Values reset after every fracture.

---

<hr style="border: none; border-top: 2px solid #888; margin:4em 0 1em;" />

<h2 style="text-align:center; border-top: none; padding-top: 0; margin-top: 0;">Fracture Team</h2>

<script setup>
import { VPTeamMembers } from 'vitepress/theme'

const team = [
  {
    avatar: 'https://avatars.githubusercontent.com/u/50461722?v=4',
    name: 'Gleb Tsereteli',
    title: 'Developer',
    links: [
      { icon: 'github', link: 'https://github.com/GlebTsereteli' },
      { icon: 'twitter', link: 'https://x.com/GlebTsereteli' },
      { icon: 'bluesky', link: 'https://bsky.app/profile/glebtsereteli.bsky.social' },
    ]
  },
  {
    avatar: 'https://avatars.githubusercontent.com/u/159041753?v=4',
    name: 'Kate',
    title: 'Graphics',
    links: [
      { icon: 'linkedin', link: 'https://www.linkedin.com/in/kate-ivanova22/' },
      { icon: 'instagram', link: 'https://www.instagram.com/k8te_iv' },
    ]
  },
]
</script>

<VPTeamMembers :members="team" />