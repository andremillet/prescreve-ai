#!/bin/bash

# Script para corrigir o erro de build do Docusaurus relacionado ao prism-react-renderer

echo "🔍 Corrigindo configuração do Docusaurus para o GitHub Pages..."

# Verificar se o arquivo docusaurus.config.js existe
if [ ! -f docusaurus.config.js ]; then
    echo "❌ Arquivo docusaurus.config.js não encontrado. Execute este script no diretório raiz do projeto."
    exit 1
fi

# Atualizar o package.json para adicionar a dependência prism-react-renderer
if [ -f package.json ]; then
    echo "📦 Adicionando dependência prism-react-renderer ao package.json..."
    
    # Usar jq se disponível, caso contrário usar sed
    if command -v jq &> /dev/null; then
        # Fazer backup do arquivo original
        cp package.json package.json.bak
        
        # Adicionar a dependência usando jq
        jq '.dependencies["prism-react-renderer"] = "^2.3.0"' package.json > package.json.tmp
        mv package.json.tmp package.json
    else
        # Verificar se a dependência já existe
        if grep -q '"prism-react-renderer"' package.json; then
            # Atualizar a versão existente
            sed -i 's/"prism-react-renderer": "[^"]*"/"prism-react-renderer": "^2.3.0"/g' package.json
        else
            # Adicionar nova dependência
            sed -i '/"dependencies": {/ a \    "prism-react-renderer": "^2.3.0",' package.json
        fi
    fi
    
    echo "✅ Dependência adicionada ao package.json."
else
    echo "❌ Arquivo package.json não encontrado."
    exit 1
fi

# Atualizar o docusaurus.config.js para usar a importação correta de prism-react-renderer
echo "🔧 Atualizando docusaurus.config.js..."

# Criar um arquivo temporário com o conteúdo correto
cat > docusaurus.config.js.new << 'EOT'
// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: 'prescreve.ai',
  tagline: 'Prescrições, exames e encaminhamentos com linguagem natural',
  favicon: 'img/favicon.ico',

  // Set the production url of your site here
  url: 'https://YOUR_GITHUB_USERNAME.github.io',
  // Set the /<baseUrl>/ pathname under which your site is served
  // For GitHub pages deployment, it is often '/<projectName>/'
  baseUrl: '/prescreve-ai/',

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: 'YOUR_GITHUB_USERNAME', // Usually your GitHub org/user name.
  projectName: 'prescreve-ai', // Usually your repo name.

  onBrokenLinks: 'throw',
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
            'https://github.com/YOUR_GITHUB_USERNAME/prescreve-ai/tree/main/',
        },
        blog: {
          showReadingTime: true,
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            'https://github.com/YOUR_GITHUB_USERNAME/prescreve-ai/tree/main/',
        },
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
          {to: '/blog', label: 'Blog', position: 'left'},
          {
            href: 'https://github.com/YOUR_GITHUB_USERNAME/prescreve-ai',
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
                label: 'Blog',
                to: '/blog',
              },
              {
                label: 'GitHub',
                href: 'https://github.com/YOUR_GITHUB_USERNAME/prescreve-ai',
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
EOT

# Obter o nome de usuário do GitHub
echo "👤 Digite seu nome de usuário do GitHub:"
read github_username

# Substituir o nome de usuário no arquivo de configuração
sed -i "s|YOUR_GITHUB_USERNAME|$github_username|g" docusaurus.config.js.new

# Substituir o arquivo original
mv docusaurus.config.js.new docusaurus.config.js

echo "✅ Arquivo docusaurus.config.js atualizado."

# Criar ou atualizar o .gitignore
if [ ! -f .gitignore ]; then
    echo "📝 Criando arquivo .gitignore..."
    cat > .gitignore << 'EOT'
# Dependências
/node_modules

# Arquivos de produção
/build
/docs/api_spec
/.docusaurus
.DS_Store
.env.local
.env.development.local
.env.test.local
.env.production.local

# Logs
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Arquivos de backup
*.bak
EOT
else
    echo "📝 Atualizando arquivo .gitignore..."
    if ! grep -q "node_modules" .gitignore; then
        echo "/node_modules" >> .gitignore
    fi
    if ! grep -q "build" .gitignore; then
        echo "/build" >> .gitignore
    fi
    if ! grep -q ".docusaurus" .gitignore; then
        echo "/.docusaurus" >> .gitignore
    fi
fi

# Atualizar o workflow do GitHub Actions
mkdir -p .github/workflows
cat > .github/workflows/documentation.yml << 'EOT'
name: Deploy Documentation to GitHub Pages

on:
  push:
    branches:
      - main
    paths:
      - 'docs/**'
      - 'src/**'
      - 'static/**'
      - 'docusaurus.config.js'
      - 'package.json'
      - '.github/workflows/documentation.yml'
      - 'sidebars.js'

  # Permite executar manualmente o workflow na interface do GitHub
  workflow_dispatch:

permissions:
  contents: write

jobs:
  deploy:
    name: Deploy to GitHub Pages
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: 18
          cache: npm

      - name: Install dependencies
        run: npm ci
      
      - name: Build website
        run: npm run build

      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./build
          user_name: github-actions[bot]
          user_email: 41898282+github-actions[bot]@users.noreply.github.com
EOT

echo "✅ Workflow do GitHub Actions atualizado."

# Verificar se o arquivo static/.nojekyll existe e criar se necessário
mkdir -p static
if [ ! -f static/.nojekyll ]; then
    touch static/.nojekyll
    echo "✅ Arquivo .nojekyll criado para evitar processamento Jekyll no GitHub Pages."
fi

echo ""
echo "🎉 Configuração corrigida com sucesso!"
echo ""
echo "Próximos passos:"
echo "1. Execute 'npm install' para instalar as dependências atualizadas"
echo "2. Faça commit e push das alterações para o GitHub"
echo "3. Verifique a aba 'Actions' no GitHub para acompanhar o processo de build"
echo ""
echo "Para testar localmente antes de fazer push:"
echo "npm start"
