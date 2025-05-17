#!/bin/bash

# Script para corrigir erros de imagens faltantes no Docusaurus

echo "🖼️ Corrigindo problemas com imagens na documentação..."

# Criar diretório de assets se não existir
mkdir -p docs/assets
echo "✅ Diretório docs/assets criado/verificado."

# Verificar se a imagem interface.png existe
if [ ! -f docs/assets/interface.png ]; then
    echo "⚠️ Imagem interface.png não encontrada."
    echo "Escolha uma opção:"
    echo "1) Criar uma imagem placeholder"
    echo "2) Remover referências a imagens nos arquivos Markdown"
    read -p "Opção (1/2): " opcao_imagem
    
    if [ "$opcao_imagem" == "1" ]; then
        echo "🎨 Criando imagem placeholder..."
        
        # Verificar se o ImageMagick está instalado
        if command -v convert &> /dev/null; then
            # Criar um placeholder com ImageMagick
            convert -size 800x600 -background lightblue -fill black -gravity center \
                -font Arial label:"Interface do prescreve.ai\n(Placeholder)" \
                docs/assets/interface.png
            echo "✅ Imagem placeholder criada com ImageMagick."
        else
            # Criar um arquivo SVG básico como alternativa
            cat > docs/assets/interface.png << 'EOT'
<svg width="800" height="600" xmlns="http://www.w3.org/2000/svg">
  <rect width="100%" height="100%" fill="#e6f7ff"/>
  <text x="50%" y="50%" font-family="Arial" font-size="24" text-anchor="middle">
    Interface do prescreve.ai (Placeholder)
  </text>
</svg>
EOT
            echo "✅ Arquivo SVG placeholder criado como interface.png."
        fi
    else
        echo "🔍 Removendo referências a imagens nos arquivos Markdown..."
        
        # Procurar e atualizar todos os arquivos Markdown que referenciam imagens faltantes
        find docs -type f -name "*.md" | xargs grep -l "assets/interface.png" | while read file; do
            echo "📝 Atualizando $file..."
            # Substituir a linha com a imagem por um comentário
            sed -i 's|!\[Interface do prescreve.ai\](../assets/interface.png)|<!-- Imagem removida temporariamente -->|g' "$file"
            sed -i 's|!\[.*\](.*interface.png)|<!-- Imagem removida temporariamente -->|g' "$file"
        done
        echo "✅ Referências a imagens removidas."
    fi
fi

# Verificar e corrigir outros arquivos Markdown com referências a imagens
echo "🔍 Verificando referências a outras imagens nos arquivos Markdown..."

# Lista para armazenar todos os caminhos de imagem referenciados
declare -a imagens_referenciadas

# Encontrar todas as referências a imagens nos arquivos markdown
while IFS= read -r linha; do
    # Extrair o caminho da imagem da linha Markdown
    caminho_imagem=$(echo "$linha" | sed -n 's/.*!\[.*\](\(.*\))/\1/p')
    
    # Se o caminho não começar com http ou https, considerar como local
    if [[ -n "$caminho_imagem" && ! "$caminho_imagem" =~ ^https?:// ]]; then
        # Normalizar caminho relativo
        caminho_normalizado=$(echo "$caminho_imagem" | sed 's|^\.\./||g')
        
        # Se não começar com /, adicionar o prefixo docs/
        if [[ ! "$caminho_normalizado" == /* ]]; then
            if [[ ! "$caminho_normalizado" == docs/* ]]; then
                caminho_normalizado="docs/$caminho_normalizado"
            fi
        fi
        
        # Adicionar à lista se ainda não estiver
        if [[ ! " ${imagens_referenciadas[@]} " =~ " ${caminho_normalizado} " ]]; then
            imagens_referenciadas+=("$caminho_normalizado")
        fi
    fi
done < <(grep -r "!\[" --include="*.md" docs/)

# Verificar cada imagem referenciada e criar placeholders se necessário
for imagem in "${imagens_referenciadas[@]}"; do
    diretorio_pai=$(dirname "$imagem")
    
    echo "🔍 Verificando imagem: $imagem"
    
    if [ ! -f "$imagem" ]; then
        echo "⚠️ Imagem não encontrada: $imagem"
        
        # Criar o diretório pai se não existir
        mkdir -p "$diretorio_pai"
        
        # Criar um placeholder básico
        echo "🎨 Criando imagem placeholder para: $imagem"
        
        # Nome da imagem sem caminho
        nome_imagem=$(basename "$imagem")
        
        # Verificar se o ImageMagick está instalado
        if command -v convert &> /dev/null; then
            # Criar um placeholder com ImageMagick
            convert -size 800x600 -background lightblue -fill black -gravity center \
                -font Arial label:"$nome_imagem\n(Placeholder)" \
                "$imagem"
        else
            # Criar um arquivo SVG básico como alternativa
            cat > "$imagem" << EOT
<svg width="800" height="600" xmlns="http://www.w3.org/2000/svg">
  <rect width="100%" height="100%" fill="#e6f7ff"/>
  <text x="50%" y="50%" font-family="Arial" font-size="24" text-anchor="middle">
    $nome_imagem (Placeholder)
  </text>
</svg>
EOT
        fi
        
        echo "✅ Placeholder criado: $imagem"
    fi
done

# Criar um logo básico para o prescreve.ai se não existir
mkdir -p static/img
if [ ! -f static/img/logo.svg ]; then
    echo "🎨 Criando logo básico do prescreve.ai..."
    
    cat > static/img/logo.svg << 'EOT'
<svg width="200" height="200" xmlns="http://www.w3.org/2000/svg">
  <circle cx="100" cy="100" r="90" fill="#ffffff" stroke="#3182ce" stroke-width="10"/>
  <text x="100" y="90" font-family="Arial" font-size="24" font-weight="bold" text-anchor="middle" fill="#3182ce">
    prescreve
  </text>
  <text x="100" y="130" font-family="Arial" font-size="36" font-weight="bold" text-anchor="middle" fill="#3182ce">
    .ai
  </text>
</svg>
EOT
    echo "✅ Logo básico criado: static/img/logo.svg"
fi

# Criar um favicon básico se não existir
if [ ! -f static/img/favicon.ico ]; then
    echo "🎨 Criando favicon básico..."
    
    # Verificar se o ImageMagick está instalado
    if command -v convert &> /dev/null; then
        # Criar um favicon com ImageMagick
        convert -size 32x32 -background transparent -fill "#3182ce" -gravity center \
            -font Arial -pointsize 16 label:"P" \
            static/img/favicon.ico
        echo "✅ Favicon criado com ImageMagick."
    else
        # Criar um arquivo SVG básico como alternativa
        cat > static/img/favicon.svg << 'EOT'
<svg width="32" height="32" xmlns="http://www.w3.org/2000/svg">
  <circle cx="16" cy="16" r="14" fill="#3182ce"/>
  <text x="16" y="22" font-family="Arial" font-size="18" font-weight="bold" text-anchor="middle" fill="white">P</text>
</svg>
EOT
        # Copiar SVG como favicon.ico para compatibilidade
        cp static/img/favicon.svg static/img/favicon.ico
        echo "✅ Arquivo SVG criado como favicon alternativo."
    fi
fi

# Criar social-card.jpg se não existir
if [ ! -f static/img/social-card.jpg ]; then
    echo "🎨 Criando imagem para social card..."
    
    # Verificar se o ImageMagick está instalado
    if command -v convert &> /dev/null; then
        # Criar uma imagem de social card com ImageMagick
        convert -size 1200x630 -background "#3182ce" -fill white -gravity center \
            -font Arial -pointsize 72 label:"prescreve.ai" \
            static/img/social-card.jpg
        echo "✅ Social card criado com ImageMagick."
    else
        # Criar um arquivo de texto como placeholder
        echo "prescreve.ai - Social Card Placeholder" > static/img/social-card.txt
        echo "✅ Arquivo de texto criado como placeholder para social card."
    fi
fi

echo ""
echo "🎉 Correção de imagens concluída!"
echo ""
echo "Próximos passos:"
echo "1. Execute 'npm start' para testar localmente"
echo "2. Se tudo estiver OK, faça commit e push das alterações"
echo ""
echo "Se ainda houver problemas com imagens, considere:"
echo "- Substituir as imagens placeholder por imagens reais"
echo "- Modificar os arquivos Markdown para remover referências a imagens que não são essenciais"