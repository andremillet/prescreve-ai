#!/bin/bash

# Script corrigido para configurar o Docusaurus para a documentação do prescreve.ai

echo "🚀 Configurando o Docusaurus para a documentação do prescreve.ai..."

# Verificar se o Node.js está instalado
if ! command -v node &> /dev/null; then
    echo "❌ Node.js não encontrado. Por favor, instale o Node.js antes de continuar."
    exit 1
fi

# Verificar se o npm está instalado
if ! command -v npm &> /dev/null; then
    echo "❌ npm não encontrado. Por favor, instale o npm antes de continuar."
    exit 1
fi

# Diretório atual
CURRENT_DIR=$(pwd)
DOCS_DIR="$CURRENT_DIR/docs"

# Criar diretório temporário para o projeto Docusaurus
TEMP_DIR=$(mktemp -d)
echo "📁 Criando projeto Docusaurus em diretório temporário: $TEMP_DIR"

# Criar projeto Docusaurus em diretório temporário
echo "📦 Criando projeto Docusaurus..."
cd "$TEMP_DIR"
npx create-docusaurus@latest temp-docusaurus classic

# Verificar se a criação foi bem-sucedida
if [ ! -d "$TEMP_DIR/temp-docusaurus" ]; then
    echo "❌ Falha ao criar o projeto Docusaurus."
    exit 1
fi

# Mover para o projeto temporário
cd "$TEMP_DIR/temp-docusaurus"

# Copiar arquivos essenciais para o diretório principal
echo "📋 Copiando arquivos Docusaurus para o diretório principal..."
cp package.json "$CURRENT_DIR/"
cp package-lock.json "$CURRENT_DIR/" 2>/dev/null || true
cp -r src "$CURRENT_DIR/"
cp -r static "$CURRENT_DIR/"
cp babel.config.js "$CURRENT_DIR/" 2>/dev/null || true
cp docusaurus.config.js "$CURRENT_DIR/"
cp sidebars.js "$CURRENT_DIR/"
cp tsconfig.json "$CURRENT_DIR/" 2>/dev/null || true
cp -r .docusaurus "$CURRENT_DIR/" 2>/dev/null || true

# Voltar para o diretório principal
cd "$CURRENT_DIR"

# Verificar e criar diretório docs se não existir
if [ ! -d "$CURRENT_DIR/docs" ]; then
    echo "❌ Diretório docs não encontrado. Verifique se o script setup_docs.sh foi executado."
    exit 1
fi

# Remover o diretório temporário
rm -rf "$TEMP_DIR"

# Ajustar configuração do Docusaurus
echo "🔧 Ajustando configuração do Docusaurus..."

# Atualizar docusaurus.config.js para apontar para o diretório docs correto
sed -i.bak 's|docs: {|docs: {\n      routeBasePath: "/",|g' docusaurus.config.js
sed -i.bak 's|https://github.com/facebook/docusaurus/tree/main/packages/create-docusaurus/templates/shared/|https://github.com/prescreve-ai/prescreve-ai-docs/tree/main/|g' docusaurus.config.js

# Limpar arquivos de backup
rm docusaurus.config.js.bak 2>/dev/null || true

# Instalar dependências
echo "📚 Instalando dependências..."
npm install

# Criar script para iniciar o servidor em modo de desenvolvimento
cat > start_docs.sh << 'EOT'
#!/bin/bash
echo "🚀 Iniciando servidor de documentação..."
npm start
EOT
chmod +x start_docs.sh

# Criar script para construir a documentação estática
cat > build_docs.sh << 'EOT'
#!/bin/bash
echo "🏗️ Construindo documentação estática..."
npm run build
EOT
chmod +x build_docs.sh

echo "✅ Configuração concluída!"
echo ""
echo "Para iniciar o servidor de desenvolvimento, execute:"
echo "./start_docs.sh"
echo ""
echo "Para construir a documentação estática, execute:"
echo "./build_docs.sh"