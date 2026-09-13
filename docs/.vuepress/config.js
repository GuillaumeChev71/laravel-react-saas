import { defineUserConfig } from 'vuepress';
import { defaultTheme } from '@vuepress/theme-default';
import { viteBundler } from '@vuepress/bundler-vite';

export default defineUserConfig({
  base: '/',
  lang: 'fr-FR',
  title: 'Laravel React SaaS',
  description: 'Documentation du projet Laravel React SaaS',

  bundler: viteBundler(),

  theme: defaultTheme({
    repo: '',
    editLink: false,
    lastUpdated: false,
    contributors: false,

    navbar: [
      { text: 'Guide', link: '/guide/' },
      { text: 'Commandes', link: '/guide/commands' },
    ],

    sidebar: {
      '/guide/': [
        {
          text: 'Introduction',
          children: [
            '/guide/',
            '/guide/stack',
          ],
        },
        {
          text: 'Installation',
          children: [
            '/guide/installation',
            '/guide/database',
          ],
        },
        {
          text: 'Développement',
          children: [
            '/guide/development',
            '/guide/commands',
          ],
        },
      ],
    },
  }),
});
