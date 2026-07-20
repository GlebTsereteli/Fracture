import { defineConfig } from 'vitepress'
import MarkdownIt from 'markdown-it'

export default defineConfig({
  base: '/Fracture/',
  cleanUrls: true,
  
  ignoreDeadLinks: true,
  lastUpdated: true,
  
  title: "Fracture",
  description: "Fracture Documentation",
  head: [
    ['link', { rel: 'icon', href: 'logoBig.png' }],

    // Embeds
    ["meta", { property: "og:title", content: "Fracture Documentation" }],
    ["meta", { property: "og:description", content: "Documentation for the Fracture GameMaker library. Setup instructions, usage examples and full API coverage." }],
    ["meta", { property: "og:type", content: "website" }],
    ["meta", { property: "og:url", content: "https://glebtsereteli.github.io/Fracture/" }],
    ["meta", { property: "og:image", content: "https://glebtsereteli.github.io/Fracture/socialEmbed.png" }],

    ["meta", { name: "twitter:card", content: "summary_large_image" }],
    ["meta", { name: "twitter:title", content: "Fracture Documentation" }],
    ["meta", { name: "twitter:description", content: "Documentation for the Fracture GameMaker library. Setup instructions, usage examples and full API coverage." }],
    ["meta", { name: "twitter:image", content: "https://glebtsereteli.github.io/Fracture/socialEmbed.png" }],
  
    // Analytics
    [
      'script',
      { async: '', src: 'https://www.googletagmanager.com/gtag/js?id=G-FBXGHSN5QK' }
    ],
    [
      'script',
      {},
      `window.dataLayer = window.dataLayer || [];
       function gtag(){dataLayer.push(arguments);}
       gtag('js', new Date());
       gtag('config', 'G-FBXGHSN5QK');`
    ]
  ],

  themeConfig: {
    logo: '/logoBig.png',

    search: {
      provider: 'local'
    },

    nav: [
      {
        text: 'Guide',
        items: [
          {
            text: '🏡 Home',
            items: [
              { text: 'What is Fracture?', link: '/home/whatIsIt/whatIsIt' },
              { text: 'Getting Started', link: '/home/gettingStarted' },
              { text: 'Upcoming Features', link: '/home/upcomingFeatures' },
              { text: 'FAQ', link: '/home/faq' },
            ]
          },
          {
            text: '📝 Topics',
            items: [
              { text: 'Requirements', link: '/topics/requirements' },
              { text: 'Pieces', link: '/topics/pieces' },
              { text: 'Rendering', link: '/topics/rendering' },
              { text: 'Performance', link: '/topics/performance' },
            ]
          },
        ]
      },
      { 
        text: 'API',
        activeMatch: '^/api/',
        items: [
          { 
            text: '🧩 Fracture',
            items: [
              { text: 'Convex Fracturing', link: '/api/fracture/convexFracturing' },
              { text: 'Settings', link: '/api/fracture/settings' },
              { text: 'Lifecycle', link: '/api/fracture/lifecycle' },
            ]
          },
          { text: '🔧 Configuration', link: '/api/config', },
        ]
      },
      { text: 'Download', link: 'https://github.com/glebtsereteli/Fracture/releases/latest/' },
    ],
    
    outline: [2, 3],
    sidebar: [
      {
        text: '🏡 Home',
        link: '/home/whatIsIt/whatIsIt',
        items: [
          { text: 'What is Fracture?', link: '/home/whatIsIt/whatIsIt' },
          { text: 'Getting Started', link: '/home/gettingStarted' },
          { text: 'Upcoming Features', link: '/home/upcomingFeatures' },
          { text: 'FAQ', link: '/home/faq' },
        ]
      },
      {
        text: '📝 Topics',
        items: [
          { text: 'Requirements', link: '/topics/requirements' },
          { text: 'Pieces', link: '/topics/pieces' },
          { text: 'Rendering', link: '/topics/rendering' },
          { text: 'Performance', link: '/topics/performance' },
        ]
      },
      {
        text: '💻 API',
        items: [
          {
            text: 'Fracture',
            link: '/api/fracture/overview',
            items: [
              { text: 'Convex Fracturing', link: '/api/fracture/convexFracturing' },
              { text: 'Settings', link: '/api/fracture/settings' },
              { text: 'Lifecycle', link: '/api/fracture/lifecycle' },
            ]
          },
          { text: 'Configuration', link: '/api/config' },
        ]
      },
    ],
    
    socialLinks: [
      { icon: 'github', link: 'https://github.com/glebtsereteli/Fracture' },
      {
        icon: {
          svg: `<svg xmlns="http://www.w3.org/2000/svg" height="235.452" width="261.728" viewBox="0 0 245.37069 220.73612"><path d="M31.99 1.365C21.287 7.72.2 31.945 0 38.298v10.516C0 62.144 12.46 73.86 23.773 73.86c13.584 0 24.902-11.258 24.903-24.62 0 13.362 10.93 24.62 24.515 24.62 13.586 0 24.165-11.258 24.165-24.62 0 13.362 11.622 24.62 25.207 24.62h.246c13.586 0 25.208-11.258 25.208-24.62 0 13.362 10.58 24.62 24.164 24.62 13.585 0 24.515-11.258 24.515-24.62 0 13.362 11.32 24.62 24.903 24.62 11.313 0 23.773-11.714 23.773-25.046V38.298c-.2-6.354-21.287-30.58-31.988-36.933C180.118.197 157.056-.005 122.685 0c-34.37.003-81.228.54-90.697 1.365zm65.194 66.217a28.025 28.025 0 0 1-4.78 6.155c-5.128 5.014-12.157 8.122-19.906 8.122a28.482 28.482 0 0 1-19.948-8.126c-1.858-1.82-3.27-3.766-4.563-6.032l-.006.004c-1.292 2.27-3.092 4.215-4.954 6.037a28.5 28.5 0 0 1-19.948 8.12c-.934 0-1.906-.258-2.692-.528-1.092 11.372-1.553 22.24-1.716 30.164l-.002.045c-.02 4.024-.04 7.333-.06 11.93.21 23.86-2.363 77.334 10.52 90.473 19.964 4.655 56.7 6.775 93.555 6.788h.006c36.854-.013 73.59-2.133 93.554-6.788 12.883-13.14 10.31-66.614 10.52-90.474-.022-4.596-.04-7.905-.06-11.93l-.003-.045c-.162-7.926-.623-18.793-1.715-30.165-.786.27-1.757.528-2.692.528a28.5 28.5 0 0 1-19.948-8.12c-1.862-1.822-3.662-3.766-4.955-6.037l-.006-.004c-1.294 2.266-2.705 4.213-4.563 6.032a28.48 28.48 0 0 1-19.947 8.125c-7.748 0-14.778-3.11-19.906-8.123a28.025 28.025 0 0 1-4.78-6.155 27.99 27.99 0 0 1-4.736 6.155 28.49 28.49 0 0 1-19.95 8.124c-.27 0-.54-.012-.81-.02h-.007c-.27.008-.54.02-.813.02a28.49 28.49 0 0 1-19.95-8.123 27.992 27.992 0 0 1-4.736-6.155zm-20.486 26.49l-.002.01h.015c8.113.017 15.32 0 24.25 9.746 7.028-.737 14.372-1.105 21.722-1.094h.006c7.35-.01 14.694.357 21.723 1.094 8.93-9.747 16.137-9.73 24.25-9.746h.014l-.002-.01c3.833 0 19.166 0 29.85 30.007L210 165.244c8.504 30.624-2.723 31.373-16.727 31.4-20.768-.773-32.267-15.855-32.267-30.935-11.496 1.884-24.907 2.826-38.318 2.827h-.006c-13.412 0-26.823-.943-38.318-2.827 0 15.08-11.5 30.162-32.267 30.935-14.004-.027-25.23-.775-16.726-31.4L46.85 124.08c10.684-30.007 26.017-30.007 29.85-30.007zm45.985 23.582v.006c-.02.02-21.863 20.08-25.79 27.215l14.304-.573v12.474c0 .584 5.74.346 11.486.08h.006c5.744.266 11.485.504 11.485-.08v-12.474l14.304.573c-3.928-7.135-25.79-27.215-25.79-27.215v-.006l-.003.002z" fill="currentColor"/></svg>`,
        },
        link: 'https://glebtsereteli.itch.io/fracture',
      },
      { icon: 'discord', link: 'https://discord.gg/gamemakerkitchen' },
      { icon: 'twitter', link: 'https://x.com/glebtsereteli' },
      { icon: 'bluesky', link: 'https://bsky.app/profile/glebtsereteli.bsky.social' },
    ],

    footer: {
      message: 'Released under the <a href="https://github.com/glebtsereteli/Fracture/blob/main/LICENSE">MIT License</a>. Built with <a href="https://vitepress.dev/">VitePress</a>.',
      copyright: 'Copyright © 2026 <a href="https://github.com/glebtsereteli">Gleb Tsereteli</a>'
    },

    lastUpdated: {
      text: 'Last modified on',
      formatOptions: {
        dateStyle: 'long',
        timeStyle: 'short'
      }
    },
  },
  
  markdown: {
    config: (md: MarkdownIt) => {
      const shortcuts: Record<string, string> = {
        // Types
        'Real': 'https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Overview/Data_Types.htm',
        'Bool': 'https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Overview/Data_Types.htm',
        'String': 'https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Strings/Strings.htm',
        'Array': 'https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Overview/Arrays.htm',
        'Struct': 'https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Overview/Structs.htm',
        'Undefined': 'https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Overview/Data_Types.htm',
        'Noone': 'https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Overview/Instance%20Keywords/noone.htm',
        'Enum': 'https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Overview/Variables/Constants.htm#:~:text=of%20this%20page.-,Enums,-An%20enum%20is',

        // IDs
        'Id.Layer': 'https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Asset_Management/Rooms/General_Layer_Functions/General_Layer_Functions.htm',
        'Id.Instance': 'https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Asset_Management/Instances/Instances.htm',
        'Id.Function': 'https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Overview/Script_Functions.htm',

        // Physics
        'Box2D': 'https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Physics/Physics.htm',
        'Fixture': 'https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Physics/Fixtures/Fixtures.htm',
        'Vertex Buffer': 'https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Drawing/Primitives/Primitives.htm',

        // Constants
        'Constant.Color': 'https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Drawing/Colour_And_Alpha/Colour_And_Alpha.htm',

        // Links
        'physics properties': 'https://manual.gamemaker.io/beta/en/GameMaker_Language/GML_Reference/Physics/Fixtures/Fixtures.htm#:~:text=create%20a%20star).-,Properties,-You%20can%20define',
        'Physics properties': 'https://manual.gamemaker.io/beta/en/GameMaker_Language/GML_Reference/Physics/Fixtures/Fixtures.htm#:~:text=create%20a%20star).-,Properties,-You%20can%20define',
        'New Issue': 'https://github.com/glebtsereteli/Fracture/issues/new',

        // Home
        'Getting Started': '/home/gettingStarted',
        'Upcoming Features': '/home/upcomingFeatures',
        'FAQ': '/home/faq',

        // Topics
        'Requirements': '/topics/requirements',
        'Pieces': '/topics/pieces',
        'Piece': '/topics/pieces',
        'Rendering': '/topics/rendering',
        'Performance': '/topics/performance',

        // Fracture
        'Fracture': '/api/fracture/overview',

        // Convex Fracturing
        'Convex': '/api/fracture/convexFracturing',
        'Convex Fracturing': '/api/fracture/convexFracturing',
        'Shape': '/api/fracture/convexFracturing#shapes',
        'Shapes': '/api/fracture/convexFracturing#shapes',
        'FRACTURE_CONVEX_BOX': '/api/fracture/convexFracturing#box',
        'FRACTURE_CONVEX_CIRCLE': '/api/fracture/convexFracturing#circle',
        'FRACTURE_CONVEX_HULL': '/api/fracture/convexFracturing#hull',
        'Box': '/api/fracture/convexFracturing#box',
        'Circle': '/api/fracture/convexFracturing#circle',
        'Hull': '/api/fracture/convexFracturing#hull',
        'Pattern': '/api/fracture/convexFracturing#patterns',
        'Patterns': '/api/fracture/convexFracturing#patterns',
        'ConvexGrid': '/api/fracture/convexFracturing#convexgrid',
        'ConvexBrick': '/api/fracture/convexFracturing#convexbrick',
        'ConvexDiamond': '/api/fracture/convexFracturing#convexdiamond',
        'ConvexHex': '/api/fracture/convexFracturing#convexhex',
        'ConvexRadial': '/api/fracture/convexFracturing#convexradial',
        'ConvexSlice': '/api/fracture/convexFracturing#convexslice',
        'ConvexVoronoi': '/api/fracture/convexFracturing#convexvoronoi',
        'Grid': '/api/fracture/convexFracturing#convexgrid',
        'Brick': '/api/fracture/convexFracturing#convexbrick',
        'Diamond': '/api/fracture/convexFracturing#convexdiamond',
        'Hex': '/api/fracture/convexFracturing#convexhex',
        'Radial': '/api/fracture/convexFracturing#convexradial',
        'Slice': '/api/fracture/convexFracturing#convexslice',
        'Voronoi': '/api/fracture/convexFracturing#convexvoronoi',

        // Settings
        'Settings': '/api/fracture/settings',
        'Physics': '/api/fracture/settings#physics',
        'Mass': '/api/fracture/settings#mass',
        'Impulse': '/api/fracture/settings#impulse',
        'Fade': '/api/fracture/settings#fade',
        'RenderAt': '/api/fracture/settings#renderat',

        // Lifecycle
        'Lifecycle': '/api/fracture/lifecycle',
        'Clear': '/api/fracture/lifecycle#clear',
        'ForceFade': '/api/fracture/lifecycle#forcefade',
        'Pause': '/api/fracture/lifecycle#pause',
        'Resume': '/api/fracture/lifecycle#resume',

        // Config
        'Config': '/api/config',
        'FRACTURE_DEFAULT_DEPTH': '/api/config#fracture-default-depth',
        'FRACTURE_DEFAULT_IMPULSE_STRENGTH': '/api/config#fracture-default-impulse-strength',
        'FRACTURE_DEFAULT_COLLISION_GROUP': '/api/config#fracture-default-collision-group',
        'FRACTURE_DEFAULT_DENSITY': '/api/config#fracture-default-density',
        'FRACTURE_DEFAULT_RESTITUTION': '/api/config#fracture-default-restitution',
        'FRACTURE_DEFAULT_FRICTION': '/api/config#fracture-default-friction',
        'FRACTURE_DEFAULT_LINEAR_DAMPING': '/api/config#fracture-default-linear-damping',
        'FRACTURE_DEFAULT_ANGULAR_DAMPING': '/api/config#fracture-default-angular-damping',
        'FRACTURE_DEFAULT_FADE_AFTER_SETTLE': '/api/config#fracture-default-fade-after-settle',
        'FRACTURE_DEFAULT_FADE_DELAY_FROM': '/api/config#fracture-default-fade-delay-from',
        'FRACTURE_DEFAULT_FADE_DELAY_TO': '/api/config#fracture-default-fade-delay-to',
        'FRACTURE_DEFAULT_FADE_SPEED_FROM': '/api/config#fracture-default-fade-speed-from',
        'FRACTURE_DEFAULT_FADE_SPEED_TO': '/api/config#fracture-default-fade-speed-to',
        'FRACTURE_BENCHMARK': '/api/config#fracture-benchmark',
      }
      
      // Generate a .Name() variation for every shortcut
      for (const key of Object.keys(shortcuts)) {
        shortcuts[`.${key}()`] = shortcuts[key]
      }
      
      // Markdown-it rule
      md.inline.ruler.before('link', 'shortcuts', (state, silent) => {
        for (const key in shortcuts) {
          const tokenText = `:${key}:`
          if (state.src.startsWith(tokenText, state.pos)) {
            if (!silent) {
              const token = state.push('link_open', 'a', 1)
              token.attrs = [['href', shortcuts[key]]]
              state.push('text', '', 0).content = key
              state.push('link_close', 'a', -1)
            }
            state.pos += tokenText.length
            return true
          }
        }
        return false
      })
    }
  },
})