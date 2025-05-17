#!/bin/bash

# Script para personalizar a página inicial do Docusaurus para o prescreve.ai

echo "🎨 Personalizando o Docusaurus para o prescreve.ai..."

# Verificar se estamos no diretório raiz do projeto
if [ ! -f "docusaurus.config.js" ]; then
    echo "❌ Arquivo docusaurus.config.js não encontrado. Execute este script no diretório raiz do projeto."
    exit 1
fi

# 1. Modificar docusaurus.config.js para redirecionar a raiz para a documentação
echo "📝 Atualizando configuração do Docusaurus..."

# Verificar se o routeBasePath já está configurado
if grep -q "routeBasePath: '/'" docusaurus.config.js; then
    echo "✅ Configuração de routeBasePath já está definida."
else
    # Atualizar a configuração para a documentação aparecer na raiz
    sed -i.bak 's|docs: {|docs: {\n          routeBasePath: "/",|g' docusaurus.config.js
    
    # Se a linha foi adicionada com sucesso
    if grep -q "routeBasePath: \"/\"" docusaurus.config.js; then
        echo "✅ Configuração de routeBasePath adicionada."
    else
        echo "⚠️ Falha ao adicionar routeBasePath. Adicionando manualmente..."
        # Tentar outro método de substituição
        sed -i.bak 's|sidebarPath: require.resolve("./sidebars.js"),|sidebarPath: require.resolve("./sidebars.js"),\n          routeBasePath: "/",|g' docusaurus.config.js
    fi
fi

# Limpar arquivo de backup
rm -f docusaurus.config.js.bak

# 2. Personalizar as cores no arquivo custom.css
echo "🎨 Personalizando cores e estilos..."

# Cores do prescreve.ai (tons de verde e azul)
PRIMARY_COLOR="#2E936C"
PRIMARY_DARK_COLOR="#236e51"
BACKGROUND_COLOR="#f9fafb"

# Verificar se o diretório src/css existe
if [ -d "src/css" ]; then
    # Criar ou atualizar o arquivo custom.css
    cat > src/css/custom.css << EOT
/**
 * Arquivo de estilo personalizado para o prescreve.ai
 */

:root {
  --ifm-color-primary: ${PRIMARY_COLOR};
  --ifm-color-primary-dark: ${PRIMARY_DARK_COLOR};
  --ifm-color-primary-darker: #1e5d44;
  --ifm-color-primary-darkest: #184a38;
  --ifm-color-primary-light: #34a97c;
  --ifm-color-primary-lighter: #39b385;
  --ifm-color-primary-lightest: #4cc798;
  --ifm-code-font-size: 95%;
  --docusaurus-highlighted-code-line-bg: rgba(0, 0, 0, 0.1);
  --ifm-font-family-base: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue', sans-serif;
  --ifm-heading-font-family: var(--ifm-font-family-base);
}

/* Para modo escuro */
[data-theme='dark'] {
  --ifm-color-primary: #4cc798;
  --ifm-color-primary-dark: #36be8a;
  --ifm-color-primary-darker: #31b382;
  --ifm-color-primary-darkest: #29946c;
  --ifm-color-primary-light: #62cda4;
  --ifm-color-primary-lighter: #6fd1ac;
  --ifm-color-primary-lightest: #8fdac0;
  --docusaurus-highlighted-code-line-bg: rgba(0, 0, 0, 0.3);
  --ifm-background-color: #1a1a1a;
}

/* Estilo para a navbar */
.navbar {
  box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.1);
}

/* Estilo para a página inicial */
.hero {
  background-color: ${PRIMARY_COLOR};
  color: white;
}

.hero__title {
  font-size: 3rem;
}

.hero__subtitle {
  font-size: 1.5rem;
  opacity: 0.9;
}

/* Estilos para cards de recursos */
.features_src-components-HomepageFeatures-styles-module {
  padding: 2rem 0;
}

.card {
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.card:hover {
  transform: translateY(-5px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

/* Estilos para a documentação */
.markdown h1 {
  font-size: 2.5rem;
  font-weight: 700;
}

.markdown h2 {
  font-size: 1.8rem;
  margin-top: 2rem;
}

.markdown code {
  background-color: rgba(46, 147, 108, 0.1);
  border-radius: 4px;
  padding: 0.2rem 0.4rem;
}

/* Adicionar fonte Inter */
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
EOT
    echo "✅ Arquivo de estilos atualizado com as cores do prescreve.ai."
else
    echo "❌ Diretório src/css não encontrado. Verifique sua instalação do Docusaurus."
    exit 1
fi

# 3. Criar uma página inicial personalizada
echo "📄 Criando página inicial personalizada..."

# Verificar se o diretório src/pages existe
mkdir -p src/pages
mkdir -p src/components/HomepageFeatures

# Criar o componente de recursos para a página inicial
cat > src/components/HomepageFeatures/index.js << 'EOT'
import React from 'react';
import clsx from 'clsx';
import styles from './styles.module.css';

const FeatureList = [
  {
    title: 'Comandos Simples',
    Svg: require('@site/static/img/undraw_typing.svg').default,
    description: (
      <>
        Use comandos intuitivos como <code>prescrever</code>, <code>solicitar</code> e <code>encaminhar</code> para criar documentos médicos rapidamente.
      </>
    ),
  },
  {
    title: 'Privacidade Garantida',
    Svg: require('@site/static/img/undraw_security.svg').default,
    description: (
      <>
        Todos os dados são processados localmente em seu dispositivo.
        Nenhuma informação de paciente é enviada para servidores externos.
      </>
    ),
  },
  {
    title: 'Adapta-se ao Seu Trabalho',
    Svg: require('@site/static/img/undraw_customize.svg').default,
    description: (
      <>
        Crie templates personalizados, adapte o modelo LLM para sua 
        especialidade e integre com sistemas existentes.
      </>
    ),
  },
];

function Feature({Svg, title, description}) {
  return (
    <div className={clsx('col col--4')}>
      <div className="text--center">
        <Svg className={styles.featureSvg} role="img" />
      </div>
      <div className="text--center padding-horiz--md">
        <h3>{title}</h3>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures() {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
EOT

# Criar o arquivo de estilos para os recursos
cat > src/components/HomepageFeatures/styles.module.css << 'EOT'
.features {
  display: flex;
  align-items: center;
  padding: 2rem 0;
  width: 100%;
}

.featureSvg {
  height: 200px;
  width: 200px;
}
EOT

# Criar a página inicial
cat > src/pages/index.js << 'EOT'
import React from 'react';
import clsx from 'clsx';
import Link from '@docusaurus/Link';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import Layout from '@theme/Layout';
import HomepageFeatures from '@site/src/components/HomepageFeatures';

import styles from './index.module.css';

function HomepageHeader() {
  const {siteConfig} = useDocusaurusContext();
  return (
    <header className={clsx('hero hero--primary', styles.heroBanner)}>
      <div className="container">
        <h1 className="hero__title">{siteConfig.title}</h1>
        <p className="hero__subtitle">{siteConfig.tagline}</p>
        <div className={styles.buttons}>
          <Link
            className="button button--secondary button--lg"
            to="/intro">
            Começar a usar o prescreve.ai
          </Link>
        </div>
      </div>
    </header>
  );
}

export default function Home() {
  const {siteConfig} = useDocusaurusContext();
  return (
    <Layout
      title={`${siteConfig.title} - Documentação`}
      description="prescreve.ai - Crie prescrições, solicitações de exames e encaminhamentos com linguagem natural">
      <HomepageHeader />
      <main>
        <HomepageFeatures />
      </main>
    </Layout>
  );
}
EOT

# Criar o arquivo de estilos para a página inicial
cat > src/pages/index.module.css << 'EOT'
/**
 * CSS específico para a página inicial
 */

.heroBanner {
  padding: 4rem 0;
  text-align: center;
  position: relative;
  overflow: hidden;
}

@media screen and (max-width: 996px) {
  .heroBanner {
    padding: 2rem;
  }
}

.buttons {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-top: 2rem;
}
EOT

echo "✅ Página inicial personalizada criada."

# 4. Criar imagens SVG para os recursos
echo "🖼️ Criando imagens para a página inicial..."

mkdir -p static/img

# Criar SVG para typing
cat > static/img/undraw_typing.svg << 'EOT'
<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" viewBox="0 0 1080 800">
  <rect x="250" y="200" width="580" height="300" rx="10" fill="#f0f0f0" stroke="#2E936C" stroke-width="8"/>
  <rect x="280" y="280" width="520" height="40" rx="5" fill="#ffffff" stroke="#2E936C" stroke-width="3"/>
  <text x="300" y="310" font-family="monospace" font-size="24" fill="#2E936C">prescrever paracetamol 500mg</text>
  <rect x="350" y="400" width="380" height="60" rx="5" fill="#2E936C" fill-opacity="0.2"/>
  <text x="540" y="440" font-family="sans-serif" font-size="24" text-anchor="middle" fill="#236e51">Comando reconhecido!</text>
</svg>
EOT

# Criar SVG para security
cat > static/img/undraw_security.svg << 'EOT'
<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" viewBox="0 0 1080 800">
  <path d="M540,200 L700,280 L700,450 C700,550 630,650 540,700 C450,650 380,550 380,450 L380,280 Z" fill="#2E936C" fill-opacity="0.2" stroke="#2E936C" stroke-width="8"/>
  <circle cx="540" cy="400" r="100" fill="#ffffff" stroke="#2E936C" stroke-width="8"/>
  <path d="M510,400 L530,430 L570,370" stroke="#2E936C" stroke-width="12" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
EOT

# Criar SVG para customize
cat > static/img/undraw_customize.svg << 'EOT'
<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" viewBox="0 0 1080 800">
  <rect x="350" y="250" width="380" height="300" rx="10" fill="#f0f0f0" stroke="#2E936C" stroke-width="8"/>
  <circle cx="400" cy="300" r="20" fill="#2E936C"/>
  <rect x="450" y="290" width="250" height="20" rx="5" fill="#2E936C" fill-opacity="0.6"/>
  <circle cx="400" cy="350" r="20" fill="#2E936C"/>
  <rect x="450" y="340" width="200" height="20" rx="5" fill="#2E936C" fill-opacity="0.6"/>
  <circle cx="400" cy="400" r="20" fill="#2E936C"/>
  <rect x="450" y="390" width="230" height="20" rx="5" fill="#2E936C" fill-opacity="0.6"/>
  <rect x="380" y="450" width="320" height="60" rx="5" fill="#2E936C"/>
  <text x="540" y="490" font-family="sans-serif" font-size="24" text-anchor="middle" fill="#ffffff">Personalizar</text>
</svg>
EOT

echo "✅ Imagens SVG criadas para a página inicial."

# 5. Atualizar o favicon e o logo, se ainda não existirem
echo "🖼️ Verificando logo e favicon..."

# Criar um logo SVG moderno para o prescreve.ai
if [ ! -f static/img/logo.svg ]; then
    cat > static/img/logo.svg << 'EOT'
<svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" viewBox="0 0 200 200">
  <rect x="40" y="40" width="120" height="120" rx="20" fill="#2E936C"/>
  <text x="100" y="110" font-family="Arial" font-size="60" font-weight="bold" text-anchor="middle" fill="#ffffff">P</text>
  <text x="100" y="140" font-family="Arial" font-size="20" font-weight="bold" text-anchor="middle" fill="#ffffff">.ai</text>
</svg>
EOT
    echo "✅ Logo SVG criado."
fi

# Verificar se a pasta static/img existe
if [ ! -d "static/img" ]; then
    mkdir -p static/img
fi

echo "✅ Personalização concluída!"
echo ""
echo "Para ver as alterações, execute:"
echo "npm start"
echo ""
echo "Agora sua documentação terá:"
echo "1. Uma página inicial personalizada para o prescreve.ai"
echo "2. Cores e estilos compatíveis com a identidade visual"
echo "3. Redirecionamento da raiz para a documentação"
echo ""
echo "Se quiser mais personalizações, edite os arquivos em:"
echo "- src/css/custom.css (para estilos)"
echo "- src/pages/index.js (para a página inicial)"
echo "- static/img/ (para imagens e ícones)"