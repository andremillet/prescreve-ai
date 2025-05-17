// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: 'prescreve.ai',
  tagline: 'Prescrições, exames e encaminhamentos com linguagem natural',
  favicon: 'img/favicon.ico',

  // Set the production url of your site here
  url: 'https://andremillet.github.io',
  // Set the /<baseUrl>/ pathname under which your site is served
  // For GitHub pages deployment, it is often '/<projectName>/'
  baseUrl: '/prescreve-ai/',

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: 'andremillet', // Usually your GitHub org/user name.
  projectName: 'prescreve-ai', // Usually your repo name.

  onBrokenLinks: "warn",
  onBrokenMarkdownLinks: 'warn',
  // Configuração para GitHub Pages
  trailingSlash: false,
  deploymentBranch: 'gh-pages',

  // Even if you don't use internalization, you can use this field to set useful
  // metadata like html lang. For example, if your site is Chinese, you may want
  // to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: 'pt-BR',
    locales: ['pt-BR'],
  },

  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          routeBasePath: '/',
          sidebarPath: require.resolve('./sidebars.js'),
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            'https://github.com/andremillet/prescreve-ai/tree/main/',
        },
        blog: false,
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      // Replace with your project's social card
      image: 'img/social-card.jpg',
      navbar: {
        title: 'prescreve.ai',
        logo: {
          alt: 'prescreve.ai Logo',
          src: 'img/logo.svg',
        },
        items: [
          {
            type: 'docSidebar',
            sidebarId: 'tutorialSidebar',
            position: 'left',
            label: 'Documentação',
          },
          
          {
            href: 'https://github.com/andremillet/prescreve-ai',
            label: 'GitHub',
            position: 'right',
          },
        ],
      },
      footer: {
        style: 'dark',
        links: [
          {
            title: 'Docs',
            items: [
              {
                label: 'Introdução',
                to: '/',
              },
              {
                label: 'Guia Rápido',
                to: '/intro/quickstart',
              },
            ],
          },
          {
            title: 'Comunidade',
            items: [
              {
                label: 'Fórum',
                href: 'https://community.prescreve.ai',
              },
              {
                label: 'Twitter',
                href: 'https://twitter.com/prescreveai',
              },
            ],
          },
          {
            title: 'Mais',
            items: [
              
              {
                label: 'GitHub',
                href: 'https://github.com/andremillet/prescreve-ai',
              },
            ],
          },
        ],
        copyright: `Copyright © ${new Date().getFullYear()} prescreve.ai. Construído com Docusaurus.`,
      },
      prism: {
        theme: require('prism-react-renderer').themes.github,
        darkTheme: require('prism-react-renderer').themes.dracula,
      },
    }),
};

module.exports = config;
