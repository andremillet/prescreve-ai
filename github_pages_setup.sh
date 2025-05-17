#!/bin/bash

# Script para configurar e implantar a documentação do prescreve.ai no GitHub Pages

echo "🚀 Configurando a documentação do prescreve.ai para GitHub Pages..."

# Verificar se git está instalado
if ! command -v git &> /dev/null; then
    echo "❌ Git não encontrado. Por favor, instale o Git antes de continuar."
    exit 1
fi

# Verificar se estamos em um repositório Git
if [ ! -d .git ]; then
    echo "⚠️ Este diretório não parece ser um repositório Git."
    read -p "Deseja inicializar um novo repositório Git? (s/n): " inicializar_git
    
    if [[ $inicializar_git == "s" || $inicializar_git == "S" ]]; then
        git init
        echo "✅ Repositório Git inicializado."
    else
        echo "❌ Abortando. Um repositório Git é necessário para o GitHub Pages."
        exit 1
    fi
fi

# Verificar e atualizar o arquivo docusaurus.config.js
if [ -f docusaurus.config.js ]; then
    echo "📝 Atualizando configuração do Docusaurus para GitHub Pages..."
    
    # Obter nome de usuário/organização e repositório do Git remoto
    remote_url=$(git config --get remote.origin.url || echo "")
    
    if [ -z "$remote_url" ]; then
        echo "⚠️ Não foi possível detectar automaticamente o repositório remoto."
        read -p "Digite seu nome de usuário/organização do GitHub: " github_username
        read -p "Digite o nome do repositório: " repo_name
    else
        if [[ $remote_url == *github.com* ]]; then
            # Extrair nome de usuário e repositório da URL
            if [[ $remote_url == *github.com:* ]]; then
                # SSH URL format: git@github.com:username/repo.git
                username_repo=${remote_url#*github.com:}
            else
                # HTTPS URL format: https://github.com/username/repo.git
                username_repo=${remote_url#*github.com/}
            fi
            
            username_repo=${username_repo%.git}
            github_username=$(echo $username_repo | cut -d'/' -f1)
            repo_name=$(echo $username_repo | cut -d'/' -f2)
        else
            echo "⚠️ O repositório remoto não parece ser do GitHub."
            read -p "Digite seu nome de usuário/organização do GitHub: " github_username
            read -p "Digite o nome do repositório: " repo_name
        fi
    fi
    
    # Atualizar configuração do Docusaurus
    sed -i.bak "s|url: 'https://docs.prescreve.ai'|url: 'https://${github_username}.github.io'|g" docusaurus.config.js
    sed -i.bak "s|baseUrl: '/'|baseUrl: '/${repo_name}/'|g" docusaurus.config.js
    sed -i.bak "s|organizationName: 'prescreve-ai'|organizationName: '${github_username}'|g" docusaurus.config.js
    sed -i.bak "s|projectName: 'prescreve-ai-docs'|projectName: '${repo_name}'|g" docusaurus.config.js
    
    # Adicionar configuração de deployment
    deployment_config="  // Configuração para GitHub Pages\n  trailingSlash: false,\n  deploymentBranch: 'gh-pages',\n"
    sed -i.bak "/onBrokenMarkdownLinks: 'warn',/a\\${deployment_config}" docusaurus.config.js
    
    # Limpar arquivos de backup
    rm docusaurus.config.js.bak
    
    echo "✅ Configuração do Docusaurus atualizada para GitHub Pages."
else
    echo "❌ Arquivo docusaurus.config.js não encontrado. Execute primeiro o script setup_docusaurus.sh."
    exit 1
fi

# Criar arquivo de workflow do GitHub Actions
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

echo "✅ Arquivo de workflow do GitHub Actions criado."

# Criar arquivo .nojekyll para evitar processamento Jekyll no GitHub Pages
touch static/.nojekyll

# Adicionar comando de deploy no package.json
if [ -f package.json ]; then
    if ! grep -q '"deploy"' package.json; then
        sed -i.bak '/scripts/a\    "deploy": "GIT_USER=<GITHUB_USERNAME> docusaurus deploy",' package.json
        rm package.json.bak
        echo "✅ Comando de deploy adicionado ao package.json."
    fi
fi

cat << 'EOT' > GITHUB_PAGES_DEPLOYMENT.md
# Implantação no GitHub Pages

Este documento explica como a documentação do prescreve.ai está configurada para implantação automática no GitHub Pages.

## Configuração Atual

A documentação está configurada para ser implantada automaticamente no GitHub Pages quando ocorrerem alterações em arquivos relevantes no branch principal. O processo de implantação é gerenciado pelo GitHub Actions.

## Fluxo de Implantação

1. Quando você envia alterações para o branch principal (`main`), o workflow do GitHub Actions é acionado
2. O GitHub Actions constrói o site usando Docusaurus
3. O site construído é implantado no branch `gh-pages`
4. O GitHub Pages serve o conteúdo a partir deste branch

## Implantação Manual

Você também pode acionar a implantação manualmente:

1. No GitHub, vá para a guia "Actions" do seu repositório
2. Selecione o workflow "Deploy Documentation to GitHub Pages"
3. Clique no botão "Run workflow"
4. Selecione o branch "main" e confirme

## Alterando a Configuração

Se você precisar alterar a configuração de implantação:

1. Edite o arquivo `.github/workflows/documentation.yml` para modificar o workflow do GitHub Actions
2. Edite o arquivo `docusaurus.config.js` para modificar configurações específicas do Docusaurus para o GitHub Pages

## Domínio Personalizado

Para usar um domínio personalizado com seu site do GitHub Pages:

1. No GitHub, vá para "Settings" > "Pages"
2. Na seção "Custom domain", digite seu domínio personalizado (ex: docs.prescreve.ai)
3. Clique em "Save"
4. Adicione um arquivo CNAME à pasta `static/` do seu projeto com o nome do domínio
5. Configure seu DNS conforme as instruções do GitHub

## Solução de Problemas

Se a implantação falhar:

1. Verifique os logs na guia "Actions" do GitHub
2. Confirme se as dependências estão instaladas corretamente
3. Verifique se o repositório tem as permissões corretas para o GitHub Actions

Para mais detalhes, consulte a [documentação do Docusaurus sobre implantação](https://docusaurus.io/docs/deployment#deploying-to-github-pages).
EOT

echo "✅ Guia de implantação do GitHub Pages criado: GITHUB_PAGES_DEPLOYMENT.md"

echo ""
echo "🎉 Configuração para GitHub Pages concluída!"
echo ""
echo "Próximos passos:"
echo "1. Se ainda não fez, crie um repositório no GitHub para este projeto"
echo "2. Adicione o repositório remoto: git remote add origin https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git"
echo "3. Envie seu código: git add . && git commit -m 'Configuração inicial' && git push -u origin main"
echo "4. A documentação será implantada automaticamente no GitHub Pages após o push"
echo "5. Seu site estará disponível em https://SEU_USUARIO.github.io/SEU_REPOSITORIO/"
echo ""
echo "Para mais detalhes, consulte o arquivo GITHUB_PAGES_DEPLOYMENT.md"