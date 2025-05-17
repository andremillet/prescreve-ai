#!/bin/bash

# Script para gerar a estrutura de documentação do prescreve.ai
# Execução: ./setup_docs.sh

echo "🚀 Iniciando a criação da documentação do prescreve.ai..."

# Criar diretório principal da documentação
mkdir -p docs

# Função para criar arquivo markdown com conteúdo
create_markdown_file() {
    local filepath=$1
    local title=$2
    local description=$3
    local position=$4
    local content=$5

    # Garantir que o diretório exista
    mkdir -p "$(dirname "$filepath")"

    # Criar o arquivo com frontmatter e conteúdo
    cat > "$filepath" << EOF
---
title: $title
sidebar_position: $position
description: $description
---

$content
EOF

    echo "✅ Criado: $filepath"
}

# ===== INTRODUÇÃO =====
intro_index_content=$(cat << 'EOT'
# Visão Geral

O **prescreve.ai** é um aplicativo médico controlado por comandos que facilita a criação de prescrições, solicitações de exames e encaminhamentos através de um LLM local.

## O que é o prescreve.ai?

O prescreve.ai é uma ferramenta moderna para profissionais de saúde que automatiza tarefas administrativas rotineiras usando processamento de linguagem natural. Através de comandos simples como "prescrever", "solicitar" e "encaminhar", médicos podem criar documentos médicos rapidamente sem precisar navegar por menus complexos.

## Principais características

- **Interface minimalista** semelhante a um chat
- **Processamento local** através de LLM como Llama
- **Privacidade garantida** - seus dados não saem do seu dispositivo
- **Exportação para PDF** de todos os documentos gerados
- **Histórico de interações** para acompanhamento do paciente

## Como funciona

O aplicativo interpreta keywords como comandos de terminal:

- `prescrever` ou `prescrevo` - para criação de prescrições médicas
- `solicitar` ou `solicito` - para requisição de exames
- `encaminhar` ou `encaminho` - para encaminhamentos a especialistas

O prescreve.ai utiliza um modelo de linguagem local para interpretar esses comandos e extrair informações relevantes como medicação, dosagem, frequência, motivos e outras especificações.

## Por que usar o prescreve.ai?

- **Economiza tempo** - reduza o tempo gasto em documentação
- **Minimiza erros** - sugestões baseadas em padrões médicos
- **Melhora a experiência do paciente** - mais tempo para interação humana
- **Funciona offline** - não depende de conexão à internet

[Comece agora →](quickstart)
EOT
)

intro_quickstart_content=$(cat << 'EOT'
# Início Rápido

Este guia vai ajudá-lo a configurar e começar a usar o prescreve.ai em minutos.

## Requisitos do Sistema

- Sistema operacional: Windows 10/11, macOS 10.15+, ou Linux
- RAM: mínimo de 8GB (16GB recomendado)
- Armazenamento: 2GB de espaço livre
- Processador: Intel i5/AMD Ryzen 5 ou superior

## Instalação

1. Baixe o instalador do prescreve.ai para seu sistema operacional em [prescreve.ai/download](https://prescreve.ai/download)
2. Execute o instalador e siga as instruções na tela
3. Na primeira execução, o aplicativo baixará o modelo LLM necessário

## Primeiro Uso

1. Abra o aplicativo prescreve.ai
2. Crie ou selecione um perfil de paciente
3. Na interface principal, digite um comando usando as keywords:

```
prescrever amoxicilina 500mg 8/8h por 7 dias para infecção de garganta
```

4. O prescreve.ai processará seu comando e gerará uma prescrição
5. Revise o documento gerado e clique em "Gerar PDF" para exportar

## Exemplos de Comandos

### Prescrever medicação
```
prescrever dipirona 500mg 6/6h por 3 dias para febre e dor
```

### Solicitar exame
```
solicitar hemograma completo para investigação de anemia
```

### Encaminhar paciente
```
encaminhar para cardiologia devido a arritmia persistente
```

## Próximos Passos

- Explore a [interface do aplicativo](../user-guide/interface)
- Aprenda mais sobre os [comandos disponíveis](../commands)
- Configure [templates personalizados](../customization/templates)
EOT
)

intro_architecture_content=$(cat << 'EOT'
# Arquitetura do Sistema

O prescreve.ai é construído com uma arquitetura moderna que prioriza desempenho, privacidade e facilidade de uso.

## Visão Geral da Arquitetura

O sistema é composto por quatro componentes principais:

1. **Interface de Usuário** - Frontend React com Tailwind CSS
2. **Motor de Processamento** - Node.js/Express com integração LLM
3. **Banco de Dados Local** - SQLite para armazenamento
4. **Gerenciador de Documentos** - Sistema de geração de PDFs

```
┌───────────────┐      ┌───────────────┐      ┌───────────────┐
│               │      │               │      │               │
│  Interface    │◄────►│  Motor de     │◄────►│  Modelo LLM   │
│  do Usuário   │      │ Processamento │      │   Local       │
│               │      │               │      │               │
└───────────────┘      └───────┬───────┘      └───────────────┘
                              │
                     ┌────────┴───────┐
                     │                │
                     │  Banco de      │
                     │  Dados Local   │
                     │                │
                     └────────────────┘
```

## Componentes Detalhados

### Interface de Usuário
- Desenvolvida em React
- Estilizada com Tailwind CSS
- Design responsivo para desktop e tablet
- Interface de chat para entrada de comandos

### Motor de Processamento
- API Node.js/Express
- Middleware para processamento de linguagem natural
- Sistema de detecção de keywords
- Extração de entidades médicas (medicamentos, dosagens, etc.)

### Modelo LLM Local
- Baseado em Llama ou Mistral
- Otimizado para terminologia médica
- Execução totalmente local para privacidade
- Baixo consumo de recursos

### Banco de Dados Local
- SQLite para armazenamento estruturado
- Criptografia de dados sensíveis
- Histórico de prescrições e solicitações
- Catálogo de medicamentos e interações

## Fluxo de Dados

1. O usuário insere um comando com keyword na interface
2. O motor de processamento identifica a intenção (prescrever/solicitar/encaminhar)
3. O comando é enviado ao LLM para extração de entidades
4. Os dados estruturados são validados e complementados com o banco de dados
5. O resultado é exibido para o usuário e pode ser editado
6. O documento final é salvo no histórico e/ou exportado como PDF

## Considerações de Segurança

- Todos os dados são processados localmente
- Nenhuma informação de paciente é enviada para servidores externos
- Backups automatizados criptografados
- Conformidade com normas de proteção de dados de saúde
EOT
)

# ===== GUIA DO USUÁRIO =====
user_guide_interface_content=$(cat << 'EOT'
# Interface do Aplicativo

O prescreve.ai possui uma interface minimalista inspirada em aplicativos de chat, projetada para ser intuitiva e eficiente.

## Visão Geral da Interface

![Interface do prescreve.ai](../assets/interface.png)

A interface do prescreve.ai é dividida em três áreas principais:

1. **Cabeçalho** - Informações do paciente e configurações
2. **Área de Mensagens** - Histórico de comandos e respostas
3. **Campo de Entrada** - Para digitação dos comandos

## Cabeçalho

O cabeçalho exibe:
- Logo e nome do aplicativo
- Informações do paciente atual (nome, idade, ID)
- Botões de acesso às configurações e perfil

Clique no nome do paciente para alternar entre pacientes diferentes ou criar um novo perfil.

## Área de Mensagens

Esta área central mostra:
- Histórico de interações com o sistema
- Comandos digitados pelo usuário
- Respostas geradas pelo prescreve.ai
- Documentos criados com opções de edição e exportação

Cada tipo de documento (prescrição, exame, encaminhamento) é destacado com cores diferentes para fácil identificação.

## Campo de Entrada

No campo de entrada na parte inferior:
- Digite comandos utilizando as keywords (`prescrever`, `solicitar`, `encaminhar`)
- Use linguagem natural para descrever o que deseja
- Pressione Enter ou clique no botão de envio para processar

## Tipos de Respostas

### Prescrições
As prescrições são exibidas em cartões azuis contendo:
- Nome do medicamento
- Dosagem e frequência
- Duração do tratamento
- Botão para exportar como PDF

### Solicitações de Exames
As solicitações de exames aparecem em cartões verdes com:
- Nome do exame
- Motivo da solicitação
- Prioridade
- Botão para gerar pedido oficial

### Encaminhamentos
Os encaminhamentos são mostrados em cartões roxos contendo:
- Especialidade de destino
- Motivo do encaminhamento
- Prioridade
- Botão para gerar documento de referência

## Atalhos de Teclado

- `Ctrl+Enter` - Enviar comando
- `Ctrl+N` - Novo paciente
- `Ctrl+H` - Exibir histórico
- `Ctrl+S` - Salvar documento atual
- `Ctrl+P` - Imprimir/exportar documento
EOT
)

user_guide_workflows_content=$(cat << 'EOT'
# Fluxos de Trabalho

O prescreve.ai foi projetado para se adaptar ao fluxo natural de uma consulta médica. Aqui estão os fluxos de trabalho comuns que você pode seguir.

## Consulta Básica

1. **Selecione o paciente**
   - Clique no seletor de paciente no cabeçalho
   - Escolha um paciente existente ou crie um novo

2. **Revise o histórico** (opcional)
   - Veja consultas anteriores na aba de histórico
   - Verifique medicações prescritas anteriormente

3. **Prescreva medicações**
   ```
   prescrever ibuprofeno 600mg 8/8h por 5 dias para dor lombar
   ```

4. **Solicite exames** (se necessário)
   ```
   solicitar raio-x de coluna lombar para investigação de dor lombar
   ```

5. **Realize encaminhamento** (se necessário)
   ```
   encaminhar para fisioterapia devido a dor lombar persistente
   ```

6. **Finalize a consulta**
   - Exporte todos os documentos como PDF
   - Envie por e-mail ou imprima diretamente

## Atendimento de Retorno

1. **Localize o paciente**
   - Use a função de busca para encontrar rapidamente o paciente

2. **Revise histórico e exames**
   - Verifique as prescrições anteriores
   - Analise os resultados de exames disponíveis

3. **Ajuste tratamentos**
   ```
   prescrever prednisona 20mg 1x ao dia por 7 dias para controle da crise asmática com redução gradual
   ```

4. **Documente evolução**
   - Use a função de anotações para registrar a evolução
   - Vincule aos documentos anteriores

## Gestão de Condições Crônicas

1. **Selecione o paciente com condição crônica**

2. **Verifique aderência ao tratamento**
   - Revise o histórico de dispensação de medicamentos

3. **Renove prescrições**
   ```
   prescrever losartana 50mg 1x ao dia para hipertensão arterial uso contínuo
   ```

4. **Agende monitoramento**
   ```
   solicitar hemoglobina glicada para acompanhamento de diabetes
   ```

5. **Configure alertas**
   - Defina lembretes para resultados de exames
   - Programe alertas para renovação de receitas

## Dicas para Otimizar seu Fluxo

- **Use templates** para condições recorrentes
- **Agrupe comandos** quando possível para economizar tempo
- **Salve rascunhos** para completar mais tarde
- **Utilize atalhos de teclado** para navegação rápida
- **Configure favoritos** para medicações e exames frequentes
EOT
)

user_guide_tips_content=$(cat << 'EOT'
# Dicas e Truques

Maximize sua experiência com o prescreve.ai usando estas dicas e truques avançados.

## Comandos Avançados

### Prescrições Complexas
Você pode incluir múltiplas instruções em uma prescrição:

```
prescrever paracetamol 750mg 6/6h por 3 dias para febre com recomendação para tomar após alimentação e evitar álcool
```

### Comandos Compostos
Crie múltiplos documentos com um único comando usando "e":

```
prescrever omeprazol 40mg 1x ao dia para gastrite e solicitar endoscopia digestiva alta para investigação de gastrite
```

### Usar Abreviações
O sistema reconhece abreviações médicas comuns:

```
prescrever AAS 100mg 1x/d para profilaxia CV
```

## Otimização de Prompts

Para obter os melhores resultados do LLM, considere estas práticas:

1. **Seja específico** - Inclua todas as informações necessárias
2. **Use terminologia padrão** - Facilita o reconhecimento de entidades
3. **Ordem lógica** - Medicamento → dosagem → frequência → duração → indicação
4. **Evite ambiguidades** - Especifique unidades de medida claramente

## Templates Personalizados

Crie templates para prescrições comuns:

1. Vá para Configurações → Templates
2. Clique em "Novo Template"
3. Digite o comando completo exemplo
4. Dê um nome e salve

Depois, você pode usar:

```
template hipertensão leve
```

## Atalhos de Produtividade

### Autocompletar Inteligente
Comece a digitar e pressione Tab para completar:
```
pres[Tab] ome[Tab] 20[Tab]
```

### Histórico de Comandos
Pressione a seta para cima para percorrer comandos anteriores.

### Repetir último comando
Digite `!!` para repetir o último comando.

### Editar e reenviar
Pressione Ctrl+R para editar o último comando.

## Gestão de Dados

### Exportação em Lote
Exporte múltiplos documentos de uma vez:
1. Selecione os documentos com Ctrl+Clique
2. Use Ctrl+E para exportar seleção

### Backup Manual
Para fazer backup de seus dados:
1. Vá para Configurações → Dados
2. Clique em "Fazer Backup Agora"
3. Escolha o local para salvar o arquivo

### Sincronização entre dispositivos
Configure a sincronização local:
1. Ative em Configurações → Sincronização
2. Selecione uma pasta na sua rede local
3. Configure o mesmo caminho em outros dispositivos
EOT
)

# ===== COMANDOS =====
commands_index_content=$(cat << 'EOT'
# Comandos

Os comandos são o núcleo do prescreve.ai. Eles permitem que você crie documentos médicos usando linguagem natural.

## Visão Geral

O prescreve.ai reconhece três tipos principais de comandos:

| Comando | Função | Exemplo |
|---------|--------|---------|
| `prescrever` | Cria prescrições médicas | `prescrever amoxicilina 500mg 8/8h por 7 dias` |
| `solicitar` | Gera pedidos de exames | `solicitar hemograma completo para investigação` |
| `encaminhar` | Produz encaminhamentos | `encaminhar para oftalmologia devido a perda visual` |

## Anatomia de um Comando

Os comandos seguem um padrão linguístico natural:

```
<keyword> <objeto> <especificações> para <motivo>
```

Onde:
- **keyword** é o verbo que indica a ação (prescrever, solicitar, encaminhar)
- **objeto** é o alvo da ação (medicamento, exame, especialidade)
- **especificações** são detalhes adicionais (dosagem, frequência, etc.)
- **motivo** é a justificativa clínica (opcional, mas recomendado)

## Variações Aceitas

O sistema aceita variações para maior naturalidade:

- `prescrever` ou `prescrevo`
- `solicitar` ou `solicito`
- `encaminhar` ou `encaminho`

## Processamento de Comandos

Quando você digita um comando, o prescreve.ai:

1. Identifica a keyword para determinar o tipo de documento
2. Extrai entidades relevantes (medicamento, dosagem, etc.)
3. Estrutura as informações em um formato padronizado
4. Gera uma visualização do documento para revisão
5. Permite edições manuais se necessário

## Comandos Adicionais

Além dos três comandos principais, o prescreve.ai suporta:

- `editar [id]` - Modifica um documento existente
- `histórico` - Mostra documentos anteriores
- `ajuda` - Exibe informações de suporte

Para mais detalhes, consulte as páginas específicas para cada comando:

- [Comando prescrever](prescrever)
- [Comando solicitar](solicitar)
- [Comando encaminhar](encaminhar)
EOT
)

commands_prescrever_content=$(cat << 'EOT'
# Comando prescrever

O comando `prescrever` permite criar prescrições médicas com detecção automática de medicação, dosagem, frequência e duração.

## Sintaxe

```
prescrever [medicação] [dosagem] [frequência] [duração] para [indicação]
```

Você também pode usar a variação `prescrevo` que funciona de maneira idêntica.

## Parâmetros

| Parâmetro | Descrição | Exemplos |
|-----------|-----------|----------|
| medicação | Nome do medicamento | amoxicilina, dipirona, enalapril |
| dosagem | Quantidade e unidade | 500mg, 40mg, 25mcg, 1 comprimido |
| frequência | Intervalo entre doses | 8/8h, 12/12h, 1x ao dia, 2x ao dia |
| duração | Período de tratamento | por 7 dias, por 10 dias, uso contínuo |
| indicação | Motivo clínico | para infecção, para hipertensão |

## Exemplos

### Prescrição básica
```
prescrever paracetamol 500mg 6/6h por 3 dias para febre
```

### Com posologia detalhada
```
prescrever enalapril 10mg 1x ao dia pela manhã para hipertensão arterial uso contínuo
```

### Com instruções especiais
```
prescrever insulina NPH 10UI antes do café da manhã e 5UI antes do jantar para diabetes
```

### Múltiplos medicamentos
Para prescrever vários medicamentos, use comandos separados:
```
prescrever amoxicilina 500mg 8/8h por 7 dias para infecção
prescrever paracetamol 750mg 6/6h se dor ou febre
```

## Características Especiais

### Detecção de interações
O sistema alerta automaticamente sobre:
- Interações medicamentosas
- Alergias registradas no perfil do paciente
- Contraindicações baseadas no histórico

### Autocorreção
O sistema pode sugerir correções para:
- Erros de digitação em nomes de medicamentos
- Dosagens incomuns
- Frequências atípicas

### Personalização
Você pode personalizar o formato de prescrição em:
Configurações → Documentos → Templates de Prescrição

## Limitações

- Medicamentos controlados requerem informações adicionais
- Alguns medicamentos podem exigir dados específicos do paciente
- Prescrições complexas podem precisar de ajuste manual
EOT
)

commands_solicitar_content=$(cat << 'EOT'
# Comando solicitar

O comando `solicitar` permite gerar pedidos de exames com detecção automática do tipo de exame, justificativa e prioridade.

## Sintaxe

```
solicitar [exame] para [motivo] com prioridade [prioridade]
```

Você também pode usar a variação `solicito` que funciona de maneira idêntica.

## Parâmetros

| Parâmetro | Descrição | Exemplos |
|-----------|-----------|----------|
| exame | Nome do exame ou procedimento | hemograma, raio-x tórax, ultrassom abdome |
| motivo | Justificativa clínica | investigação de anemia, acompanhamento de pneumonia |
| prioridade | Urgência do exame (opcional) | urgente, rotina, emergência |

## Exemplos

### Solicitação básica
```
solicitar hemograma completo para investigação de anemia
```

### Com prioridade especificada
```
solicitar tomografia de crânio para avaliação de cefaleia persistente com prioridade urgente
```

### Múltiplos exames relacionados
```
solicitar hemograma, PCR e VHS para investigação de processo inflamatório
```

### Com informações clínicas adicionais
```
solicitar ecocardiograma para avaliação de sopro cardíaco em paciente com história familiar de cardiopatia
```

## Características Especiais

### Agrupamento Inteligente
O sistema automaticamente:
- Agrupa exames relacionados em um mesmo pedido
- Sugere exames complementares relevantes
- Organiza os pedidos por laboratório/setor

### Detecção de Repetições
O prescreve.ai alerta sobre:
- Exames similares solicitados recentemente
- Padrões de repetição excessiva
- Disponibilidade de resultados anteriores

### Formatação por Convênio
É possível configurar templates de solicitação específicos para:
- Diferentes convênios médicos
- Sistema público de saúde
- Particular

## Protocolos Clínicos

O sistema suporta protocolos pré-configurados para solicitações padronizadas:

```
solicitar protocolo pré-operatório para cirurgia eletiva
```

```
solicitar protocolo gestante primeiro trimestre
```

## Exames Especiais

Alguns exames podem requerer informações adicionais:

- **Exames contrastados**: O sistema solicitará dados de função renal
- **Exames hormonais**: O sistema perguntará sobre fase do ciclo menstrual
- **Exames genéticos**: Serão solicitadas informações sobre histórico familiar
EOT
)

commands_encaminhar_content=$(cat << 'EOT'
# Comando encaminhar

O comando `encaminhar` permite criar encaminhamentos para especialistas com detecção automática da especialidade, motivo e prioridade.

## Sintaxe

```
encaminhar para [especialidade] devido a [motivo] com prioridade [prioridade]
```

Você também pode usar a variação `encaminho` que funciona de maneira idêntica.

## Parâmetros

| Parâmetro | Descrição | Exemplos |
|-----------|-----------|----------|
| especialidade | Área médica de destino | cardiologia, neurologia, ortopedia |
| motivo | Justificativa clínica | avaliação de arritmia, dor lombar crônica |
| prioridade | Urgência do encaminhamento (opcional) | urgente, rotina, emergência |

## Exemplos

### Encaminhamento básico
```
encaminhar para oftalmologia devido a diminuição da acuidade visual
```

### Com prioridade especificada
```
encaminhar para cardiologia devido a dor torácica atípica com prioridade urgente
```

### Com histórico detalhado
```
encaminhar para gastroenterologia devido a epigastralgia persistente não responsiva a IBP por 4 semanas
```

### Com resultados de exames
```
encaminhar para endocrinologia devido a TSH elevado (valor: 8.5) para avaliação de hipotireoidismo
```

## Características Especiais

### Direcionamento Inteligente
O sistema automaticamente:
- Sugere a especialidade mais adequada com base nos sintomas
- Alerta sobre casos que podem necessitar atendimento de emergência
- Identifica serviços disponíveis na região do paciente

### Informações Relevantes
O prescreve.ai inclui automaticamente:
- Resumo relevante do histórico médico
- Medicações em uso relacionadas ao motivo
- Resultados de exames pertinentes

### Personalização por Rede
É possível configurar o direcionamento específico para:
- Diferentes redes de atendimento
- Sistema público de saúde
- Clínicas particulares conveniadas

## Referência e Contra-referência

O sistema suporta o ciclo completo de referência:

```
encaminhar para neurologia com solicitação de contra-referência após avaliação
```

Para receber encaminhamentos:
```
receber encaminhamento [ID] com feedback [observações]
```

## Tipos Especiais de Encaminhamento

### Encaminhamento Multiprofissional
Para profissionais não-médicos:

```
encaminhar para nutrição para manejo de obesidade
```

```
encaminhar para fisioterapia devido a lombalgia crônica
```

### Encaminhamento para Serviços
Para serviços específicos:

```
encaminhar para serviço de cuidados paliativos
```

```
encaminhar para programa de cessação de tabagismo
```
EOT
)

# ===== LLM INTEGRATION =====
llm_setup_content=$(cat << 'EOT'
# Configurando o LLM

O prescreve.ai utiliza um modelo de linguagem local (LLM) para processar comandos e extrair informações médicas. Este guia mostrará como configurar e otimizar o modelo para seu uso.

## Modelos Suportados

O prescreve.ai é compatível com vários modelos LLM:

| Modelo | Tamanho | RAM Recomendada | Precisão |
|--------|---------|-----------------|----------|
| Llama 3 8B | ~4GB | 8GB | INT8 |
| Llama 3 70B | ~35GB | 64GB | INT4 |
| Mistral 7B | ~4GB | 8GB | INT8 |
| Phi-3 | ~2GB | 6GB | INT8 |

## Instalação do Modelo

Na primeira execução do prescreve.ai, você será guiado pelo processo de instalação do modelo. Alternativamente:

1. Vá para Configurações → LLM
2. Clique em "Baixar Modelo"
3. Selecione o modelo desejado (recomendamos Llama 3 8B para a maioria dos casos)
4. Aguarde o download e instalação

## Configurações Avançadas

### Ajustes de Performance

Você pode ajustar o equilíbrio entre precisão e velocidade:

- **Modo Rápido**: Prioriza velocidade, ideal para hardware limitado
- **Modo Equilibrado**: Configuração padrão recomendada
- **Modo Preciso**: Maximiza a precisão do reconhecimento

Para ajustar:
1. Vá para Configurações → LLM → Performance
2. Selecione o modo desejado

### Quantização

Para dispositivos com RAM limitada:

1. Vá para Configurações → LLM → Quantização
2. Selecione o nível de quantização (INT4, INT8, ou FP16)
3. Reinicie o aplicativo para aplicar as mudanças

## Integração com GPU

Para acelerar o processamento:

1. Vá para Configurações → LLM → Hardware
2. Ative "Usar GPU para inferência"
3. Selecione sua GPU na lista de dispositivos
4. Ajuste a memória dedicada ao modelo

## Atualização do Modelo

Para manter seu modelo atualizado:

1. Vá para Configurações → LLM → Atualizações
2. Clique em "Verificar Atualizações"
3. Se disponível, selecione "Atualizar Modelo"

## Solução de Problemas

### Modelo Lento

Se o processamento estiver lento:
- Reduza a precisão do modelo (use quantização INT8 ou INT4)
- Ative o uso de GPU se disponível
- Feche aplicativos em segundo plano consumindo memória

### Erros de Reconhecimento

Se o modelo não reconhece corretamente os comandos:
- Verifique se está usando a sintaxe recomendada
- Considere usar um modelo maior se disponível
- Verifique as configurações de temperatura e top_p

### Erro "Memória Insuficiente"

Se receber este erro:
- Tente um modelo menor (por exemplo, troque Llama 70B por Llama 8B)
- Aumente a quantização (INT4 em vez de INT8)
- Feche outros aplicativos consumindo RAM
- Considere adicionar mais memória ao seu sistema
EOT
)

llm_prompting_content=$(cat << 'EOT'
# Otimização de Prompts

A maneira como você estrutura seus comandos afeta diretamente a qualidade do resultado gerado pelo LLM. Este guia ensina como otimizar prompts para obter os melhores resultados.

## Princípios Básicos

### Estrutura Recomendada

Para cada tipo de comando, siga estas estruturas ideais:

**Prescrição**:
```
prescrever [medicamento] [dosagem] [frequência] [duração] para [condição]
```

**Exame**:
```
solicitar [nome do exame] para [justificativa clínica]
```

**Encaminhamento**:
```
encaminhar para [especialidade] devido a [condição] com [informações adicionais]
```

## Práticas Recomendadas

### Seja Específico
Inclua todos os detalhes relevantes para evitar ambiguidades:

```
# Menos eficaz:
prescrever amoxicilina para infecção

# Mais eficaz:
prescrever amoxicilina 500mg 8/8h por 7 dias para infecção de garganta
```

### Use Terminologia Padrão
Utilize nomes de medicamentos, exames e especialidades em seus formatos padrão:

```
# Menos eficaz:
prescrever remédio para pressão

# Mais eficaz:
prescrever losartana 50mg 1x ao dia para hipertensão arterial
```

### Especifique Unidades
Sempre inclua unidades de medida para evitar erros:

```
# Ambíguo:
prescrever metformina 500 2x dia

# Claro:
prescrever metformina 500mg 2x ao dia para diabetes
```

### Forneça Contexto
Adicione informações contextuais que auxiliem o LLM:

```
# Básico:
solicitar ultrassom

# Com contexto:
solicitar ultrassom transvaginal para paciente com sangramento pós-menopausa
```

## Técnicas Avançadas

### Prompt Chaining
Para casos complexos, divida em múltiplos comandos sequenciais:

```
# Primeira etapa:
prescrever insulina NPH 10UI antes do café da manhã para diabetes

# Segunda etapa:
prescrever insulina NPH 5UI antes do jantar para mesmo paciente
```

### Uso de Templates
Crie e utilize templates para situações recorrentes:

```
# Criando template:
salvar template "antibioticoterapia padrão" como "prescrever amoxicilina 500mg 8/8h por 7 dias para infecção"

# Usando template:
usar template "antibioticoterapia padrão"
```

### Comandos Condicionais
Especifique condições para uso do medicamento:

```
prescrever paracetamol 500mg 6/6h se temperatura acima de 38°C
```

## Exemplos por Especialidade

### Cardiologia
```
prescrever enalapril 10mg 1x ao dia pela manhã para hipertensão arterial com aumento para 20mg após 2 semanas se PA não controlada
```

### Endocrinologia
```
prescrever levotiroxina 50mcg 1x ao dia em jejum para hipotireoidismo com TSH = 12 e T4L = 0.7
```

### Psiquiatria
```
prescrever sertralina 50mg 1x ao dia por 7 dias seguido de 100mg 1x ao dia para transtorno depressivo
```

## Resolução de Problemas

### O modelo não reconhece o medicamento
- Verifique a grafia do nome do medicamento
- Use o nome genérico (ex: "fluoxetina" em vez de "Prozac")
- Especifique a classe do medicamento se necessário

### O modelo confunde dosagem ou frequência
- Separe claramente a dosagem da frequência
- Use formatação padrão (ex: "8/8h" ou "a cada 8 horas")
- Evite abreviações não padronizadas
EOT
)

llm_training_content=$(cat << 'EOT'
# Treinamento Específico para Terminologia Médica

O desempenho do prescreve.ai pode ser significativamente melhorado com um treinamento específico para terminologia médica e fluxos de trabalho clínicos. Esta seção explica como realizar esse treinamento.

## Por que Treinar o Modelo?

O treinamento específico para terminologia médica ajuda a:

- Melhorar a precisão no reconhecimento de termos médicos
- Reduzir erros em dosagens e posologias
- Adaptar o sistema ao seu estilo de prescrição
- Incluir medicamentos e protocolos específicos da sua especialidade

## Métodos de Treinamento

### 1. Aprendizado por Uso

O método mais simples é o aprendizado contínuo:

1. Use o prescreve.ai regularmente
2. Corrija manualmente os resultados quando necessário
3. O sistema aprenderá com suas correções
4. Após algumas semanas, o modelo se adaptará ao seu estilo

Para ativar:
- Vá para Configurações → LLM → Aprendizado
- Ative "Aprender com correções"

### 2. Importação de Exemplos

Você pode importar exemplos de prescrições anteriores:

1. Vá para Configurações → LLM → Treinamento
2. Clique em "Importar Exemplos"
3. Selecione um arquivo CSV ou TXT com suas prescrições
4. Mapeie as colunas para os campos relevantes
5. Inicie o processo de importação

Formato recomendado para o CSV:
```
medicamento,dosagem,frequencia,duracao,indicacao
amoxicilina,500mg,8/8h,7 dias,infecção de garganta
enalapril,10mg,1x ao dia,contínuo,hipertensão
```

### 3. Treinamento Supervisionado

Para um ajuste mais preciso:

1. Vá para Configurações → LLM → Treinamento Avançado
2. Clique em "Iniciar Treinamento Supervisionado"
3. Digite comandos conforme solicitado
4. Valide ou corrija as extrações do sistema
5. Complete o número recomendado de exemplos (50-100)

Este processo requer cerca de 30-60 minutos, mas oferece os melhores resultados.

## Configurações Avançadas de Treinamento

### Parâmetros Customizáveis

Para usuários avançados, é possível ajustar:

- **Temperatura**: Controla a criatividade do modelo (0.1-1.0)
- **Top-p**: Influencia a diversidade das respostas (0.1-1.0)
- **Taxa de aprendizado**: Velocidade do aprendizado (0.00001-0.001)
- **Épocas de treinamento**: Número de iterações (1-5)

Acesse em: Configurações → LLM → Parâmetros Avançados

### Treinamento para Especialidades

O prescreve.ai oferece datasets pré-configurados para especialidades específicas:

1. Vá para Configurações → LLM → Especialidades
2. Selecione sua especialidade (ex: Cardiologia, Pediatria)
3. Clique em "Aplicar Dataset Especializado"
4. Aguarde a conclusão do processo

## Exportação e Compartilhamento de Modelos

Após treinar seu modelo, você pode:

1. Exportar para uso em outros dispositivos:
   - Vá para Configurações → LLM → Exportar
   - Selecione "Exportar Modelo Treinado"
   - Escolha o local para salvar

2. Compartilhar com colegas (mesma clínica/hospital):
   - Exporte o modelo conforme acima
   - Compartilhe o arquivo .bin gerado
   - Os colegas podem importar em: Configurações → LLM → Importar

## Melhores Práticas

- Treine com pelo menos 50 exemplos diversos
- Inclua variações de comandos que você usa frequentemente
- Atualize o treinamento a cada 3-6 meses
- Combine métodos para melhores resultados
- Mantenha um backup do modelo base original
EOT
)

# ===== CUSTOMIZATION =====
customization_templates_content=$(cat << 'EOT'
# Templates Personalizados

O prescreve.ai permite criar templates personalizados para agilizar tarefas repetitivas. Esta seção explica como criar e gerenciar templates eficientes.

## O que são Templates?

Templates são comandos pré-configurados que podem ser invocados rapidamente para criar prescrições, solicitações ou encaminhamentos frequentes. Eles economizam tempo e garantem consistência.

## Tipos de Templates

O prescreve.ai suporta três tipos principais de templates:

1. **Templates de Prescrição**: Para medicações frequentemente prescritas
2. **Templates de Exames**: Para conjuntos de exames solicitados regularmente
3. **Templates de Encaminhamento**: Para referências padronizadas

## Criando Templates

### Via Interface Gráfica

1. Vá para Configurações → Templates
2. Clique em "Novo Template"
3. Selecione o tipo (Prescrição, Exame, Encaminhamento)
4. Preencha os campos solicitados
5. Dê um nome descritivo ao template
6. Salve o template

### Via Comando Direto

Você pode criar templates durante o uso normal:

```
salvar template "antibiótico padrão" como "prescrever amoxicilina 500mg 8/8h por 7 dias para infecção"
```

```
salvar template "check-up básico" como "solicitar hemograma completo, glicemia de jejum, perfil lipídico e TSH para check-up anual"
```

## Usando Templates

### Via Comando

Para usar um template, digite:

```
usar template "antibiótico padrão"
```

Ou a forma abreviada:

```
t antibiótico padrão
```

### Via Interface

1. Clique no botão de templates (ícone de documento) próximo ao campo de entrada
2. Selecione o template desejado da lista
3. O sistema preencherá o comando automaticamente
4. Você pode editar o comando antes de enviar

## Gerenciando Templates

### Organização por Categorias

Você pode organizar seus templates em categorias:

1. Vá para Configurações → Templates
2. Clique em "Gerenciar Categorias"
3. Crie categorias como "Antibióticos", "Cardiologia", "Exames de Rotina"
4. Arraste e solte templates para organizá-los

### Exportação e Importação

Compartilhe templates entre dispositivos ou com colegas:

1. Vá para Configurações → Templates → Exportar
2. Selecione os templates para exportar
3. Escolha um local para salvar o arquivo .ptemplates

Para importar:
1. Vá para Configurações → Templates → Importar
2. Selecione o arquivo .ptemplates
3. Escolha quais templates importar

## Templates Avançados

### Templates com Variáveis

Crie templates flexíveis usando variáveis:

```
salvar template "antibiótico dose ajustável" como "prescrever amoxicilina {dose}mg 8/8h por {dias} dias para {indicação}"
```

Para usar:
```
usar template "antibiótico dose ajustável" com dose=750, dias=10, indicação="sinusite aguda"
```

### Templates Condicionais

Crie lógica condicional em templates:

```
salvar template "analgésico" como "prescrever {se: intensidade=leve ? paracetamol 500mg : dipirona 1g} 6/6h para dor"
```

### Templates com Subrotinas

Combine múltiplos templates:

```
salvar template "infecção respiratória" como "usar template 'antibiótico padrão' + usar template 'sintomáticos'"
```

## Exemplos por Especialidade

### Clínica Geral
```
salvar template "IVAS" como "prescrever paracetamol 500mg 6/6h se febre ou dor + prescrever loratadina 10mg 1x ao dia para sintomas alérgicos + prescrever solução salina nasal 2 jatos em cada narina 3x ao dia"
```

### Cardiologia
```
salvar template "HAS inicial" como "prescrever losartana 50mg 1x ao dia para hipertensão + solicitar ECG, potássio sérico e creatinina para acompanhamento"
```

### Endocrinologia
```
salvar template "DM2 inicial" como "prescrever metformina 500mg 1x ao dia por 7 dias, seguido de 500mg 2x ao dia para diabetes + solicitar Hb glicada, microalbuminúria e perfil lipídico para avaliação inicial"
```

## Dicas de Uso

- Crie templates para seus 10-15 cenários mais comuns
- Revise e atualize templates regularmente
- Use nomes curtos e descritivos
- Combine com atalhos de teclado para máxima eficiência
EOT
)

# ===== API REFERENCE =====
api_endpoints_content=$(cat << 'EOT'
# API Endpoints

O prescreve.ai oferece uma API local para integração com outros sistemas. Esta documentação descreve os endpoints disponíveis e como utilizá-los.

## Visão Geral da API

A API do prescreve.ai é acessível localmente na porta 3456:

```
http://localhost:3456/api/v1
```

Todos os endpoints retornam respostas em formato JSON.

## Autenticação

Para acessar a API, você precisa gerar um token de API:

1. No prescreve.ai, vá para Configurações → API
2. Clique em "Gerar Token de API"
3. Copie o token gerado

Inclua o token em todas as requisições no header:

```
Authorization: Bearer seu_token_aqui
```

## Endpoints Principais

### Processamento de Comandos

**Endpoint:** `POST /api/v1/process`

Processa um comando como se fosse digitado na interface do usuário.

**Request:**
```json
{
  "command": "prescrever amoxicilina 500mg 8/8h por 7 dias para infecção",
  "patientId": "12345"
}
```

**Response:**
```json
{
  "id": "cmd_123456",
  "type": "prescription",
  "status": "success",
  "result": {
    "medication": "amoxicilina",
    "dosage": "500mg",
    "frequency": "8/8h",
    "duration": "por 7 dias",
    "indication": "infecção",
    "createdAt": "2025-05-17T14:30:00Z"
  }
}
```

### Gerenciamento de Pacientes

**Endpoint:** `GET /api/v1/patients`

Retorna a lista de pacientes cadastrados.

**Response:**
```json
{
  "patients": [
    {
      "id": "12345",
      "name": "Maria Silva",
      "age": 42,
      "createdAt": "2025-01-10T10:00:00Z",
      "lastVisit": "2025-05-15T14:30:00Z"
    },
    {
      "id": "12346",
      "name": "João Santos",
      "age": 65,
      "createdAt": "2025-02-20T09:15:00Z",
      "lastVisit": "2025-04-30T16:45:00Z"
    }
  ]
}
```

**Endpoint:** `GET /api/v1/patients/{id}`

Retorna detalhes de um paciente específico.

**Endpoint:** `POST /api/v1/patients`

Cria um novo paciente.

### Documentos

**Endpoint:** `GET /api/v1/documents`

Retorna a lista de documentos gerados (prescrições, exames, encaminhamentos).

**Endpoint:** `GET /api/v1/documents/{id}`

Retorna detalhes de um documento específico.

**Endpoint:** `GET /api/v1/documents/{id}/pdf`

Gera e retorna o PDF de um documento.

### Templates

**Endpoint:** `GET /api/v1/templates`

Retorna a lista de templates disponíveis.

**Endpoint:** `POST /api/v1/templates`

Cria um novo template.

## Exemplos de Integração

### Python
```python
import requests
import json

API_URL = "http://localhost:3456/api/v1"
API_KEY = "seu_token_aqui"

headers = {
    "Authorization": f"Bearer {API_KEY}",
    "Content-Type": "application/json"
}

# Processar um comando
response = requests.post(
    f"{API_URL}/process",
    headers=headers,
    data=json.dumps({
        "command": "prescrever paracetamol 500mg 6/6h para febre",
        "patientId": "12345"
    })
)

print(response.json())
```

### JavaScript
```javascript
const apiUrl = 'http://localhost:3456/api/v1';
const apiKey = 'seu_token_aqui';

async function processCommand(command, patientId) {
  const response = await fetch(`${apiUrl}/process`, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${apiKey}`,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      command,
      patientId
    })
  });
  
  return await response.json();
}

// Exemplo de uso
processCommand('solicitar hemograma completo para anemia', '12345')
  .then(result => console.log(result))
  .catch(error => console.error(error));
```

## Limites e Restrições

- Máximo de 100 requisições por minuto
- Tamanho máximo do corpo da requisição: 100KB
- A API está disponível apenas localmente por padrão
- Para acesso remoto, configure em Configurações → API → Acesso Remoto

## Webhooks

Configure webhooks para notificações em tempo real:

1. Vá para Configurações → API → Webhooks
2. Adicione uma URL para receber notificações
3. Selecione os eventos de interesse (nova prescrição, novo exame, etc.)

Formato dos eventos:
```json
{
  "event": "prescription.created",
  "timestamp": "2025-05-17T14:30:00Z",
  "data": {
    "id": "cmd_123456",
    "patientId": "12345",
    "medication": "amoxicilina",
    "dosage": "500mg"
  }
}
```
EOT
)

# ===== SECURITY =====
security_privacy_content=$(cat << 'EOT'
# Segurança e Privacidade

O prescreve.ai foi projetado com segurança e privacidade como prioridades fundamentais. Esta seção detalha as medidas implementadas para proteger os dados sensíveis dos pacientes.

## Modelo de Privacidade

### Processamento Local

O diferencial de privacidade do prescreve.ai é o processamento totalmente local:

- O modelo LLM é executado no próprio dispositivo
- Nenhum dado de paciente é enviado para servidores externos
- Nenhuma conexão com a internet é necessária para operação
- Sem telemetria ou rastreamento

### Zero-Knowledge Design

Implementamos um design "zero-knowledge":

- Mesmo os desenvolvedores do prescreve.ai não podem acessar seus dados
- Backups são criptografados com chave local
- Não há sincronização automática com a nuvem
- Você tem controle total sobre todos os seus dados

## Medidas de Segurança

### Criptografia

Todos os dados sensíveis são protegidos:

- Banco de dados local criptografado com AES-256
- Chaves de criptografia derivadas da senha do usuário
- Dados em trânsito (para APIs locais) protegidos com TLS 1.3
- Backups criptografados com senha adicional

### Autenticação

Acesso protegido por múltiplas camadas:

- Autenticação obrigatória no aplicativo
- Suporte para autenticação biométrica (Touch ID, Face ID)
- Opção de PIN numérico para acesso rápido
- Bloqueio automático após período de inatividade
- Proteção contra tentativas de acesso repetidas

### Isolamento de Dados

Segregação de informações sensíveis:

- Separação entre dados de pacientes diferentes
- Nível de acesso configurável por usuário
- Registro detalhado de acesso e alterações
- Suporte para múltiplos perfis de usuário

## Conformidade com Regulamentações

### Padrões Suportados

O prescreve.ai foi projetado para conformidade com:

- LGPD (Lei Geral de Proteção de Dados)
- HIPAA (Health Insurance Portability and Accountability Act)
- GDPR (General Data Protection Regulation)
- CFM/CRM (normas dos Conselhos de Medicina)

### Documentação de Conformidade

Para requisitos de auditoria, o sistema fornece:

- Registros de auditoria detalhados (audit trails)
- Histórico de alterações em dados sensíveis
- Registros de acesso por usuário
- Relatórios de conformidade exportáveis

## Backups e Recuperação

### Políticas de Backup

Proteja seus dados contra perda:

1. Configure backups automáticos em Configurações → Dados → Backup
2. Defina frequência (diária, semanal, mensal)
3. Selecione local de armazenamento (pasta local, unidade externa)
4. Defina retenção (quantos backups manter)

### Recuperação de Dados

Em caso de problemas:

1. Vá para Configurações → Dados → Recuperação
2. Selecione o arquivo de backup
3. Forneça a senha de criptografia
4. Escolha recuperação completa ou seletiva

## Melhores Práticas

### Para Administradores

- Atualize regularmente o aplicativo e o modelo LLM
- Configure políticas de senha forte
- Implemente backups redundantes
- Ative bloqueio automático após inatividade
- Realize auditorias de segurança periódicas

### Para Usuários

- Use senhas fortes e únicas
- Nunca compartilhe credenciais
- Bloqueie seu dispositivo quando não estiver em uso
- Mantenha o sistema operacional atualizado
- Evite usar o aplicativo em redes Wi-Fi públicas

## Notificação de Incidentes

Em caso de incidente de segurança:

1. O prescreve.ai oferece uma ferramenta de avaliação de impacto
2. Um assistente guiará pelas etapas de resposta necessárias
3. Modelos de notificação para pacientes afetados
4. Instruções para mitigação de riscos

Entre em contato com nosso time de segurança: seguranca@prescreve.ai
EOT
)

# ===== FAQ =====
faq_content=$(cat << 'EOT'
# Perguntas Frequentes

Esta seção responde às dúvidas mais comuns sobre o prescreve.ai.

## Perguntas Gerais

### O que é o prescreve.ai?
O prescreve.ai é um aplicativo que permite médicos criarem prescrições, solicitações de exames e encaminhamentos usando comandos em linguagem natural. Ele utiliza um modelo de linguagem local (LLM) para interpretar comandos e gerar documentos médicos formatados.

### O aplicativo funciona offline?
Sim, o prescreve.ai funciona totalmente offline. O processamento é realizado localmente no seu dispositivo, garantindo privacidade e funcionamento mesmo sem conexão à internet.

### Quais sistemas operacionais são suportados?
O prescreve.ai está disponível para Windows 10/11, macOS 10.15 ou superior, e distribuições Linux principais (Ubuntu, Fedora, Debian).

### O prescreve.ai é gratuito?
O prescreve.ai oferece uma versão gratuita com funcionalidades básicas e versões pagas com recursos avançados. Visite [prescreve.ai/planos](https://prescreve.ai/planos) para detalhes sobre licenciamento.

## Instalação e Configuração

### Quais são os requisitos mínimos de hardware?
- Processador: Intel i3/AMD Ryzen 3 ou equivalente
- Memória: 8GB RAM mínimo (16GB recomendado)
- Armazenamento: 2GB de espaço livre
- GPU: Opcional, mas recomendada para melhor desempenho

### Como instalar o modelo LLM?
Na primeira execução, o prescreve.ai solicitará o download do modelo LLM. Basta seguir as instruções na tela. Você pode gerenciar modelos em Configurações → LLM.

### Posso usar o prescreve.ai em vários dispositivos?
Sim. Você pode instalar o aplicativo em múltiplos dispositivos e transferir suas configurações e templates através da funcionalidade de exportação/importação.

### Como configurar para múltiplos médicos em uma clínica?
O prescreve.ai suporta perfis de múltiplos usuários. Cada médico pode criar seu próprio perfil com configurações e templates personalizados.

## Uso Diário

### Como começar a usar o prescreve.ai?
Após a instalação, basta abrir o aplicativo e digitar comandos usando as keywords "prescrever", "solicitar" ou "encaminhar". Por exemplo: "prescrever paracetamol 500mg 6/6h por 3 dias para febre".

### O prescreve.ai reconhece nomes comerciais de medicamentos?
Sim, o modelo reconhece tanto nomes genéricos quanto comerciais da maioria dos medicamentos. No entanto, recomendamos usar nomes genéricos quando possível.

### O aplicativo verifica interações medicamentosas?
Sim, o prescreve.ai verifica automaticamente interações entre medicamentos prescritos para o mesmo paciente e alerta sobre potenciais problemas.

### Como exportar documentos?
Cada documento gerado tem um botão "Exportar PDF" que permite salvar, imprimir ou enviar por email o documento formatado.

## Solução de Problemas

### O aplicativo está lento ao processar comandos.
Verifique:
- Se há outros aplicativos consumindo muita memória
- Ajuste as configurações de LLM para um modelo menor ou mais quantizado
- Ative a aceleração por GPU se disponível

### O LLM não reconhece corretamente meus comandos.
Tente:
- Usar a sintaxe recomendada na documentação
- Treinar o modelo com seus exemplos específicos
- Verificar se está usando terminologia médica padrão
- Atualizar para a versão mais recente do modelo

### Como recuperar dados após formatação do computador?
Se você configurou backups automáticos, use a função de Recuperação para restaurar seus dados. Caso contrário, contate o suporte em suporte@prescreve.ai para opções de recuperação.

## Integração e Extensibilidade

### O prescreve.ai se integra com prontuários eletrônicos?
Sim, oferecemos API de integração com os principais sistemas de prontuário eletrônico. Consulte a documentação de API para detalhes de implementação.

### Posso criar plugins para o prescreve.ai?
Sim, o prescreve.ai suporta plugins para estender suas funcionalidades. Documentação para desenvolvedores está disponível em [prescreve.ai/desenvolvedores](https://prescreve.ai/desenvolvedores).

### É possível adaptar o prescreve.ai para outras especialidades médicas?
Absolutamente. Você pode treinar o modelo para reconhecer terminologia específica da sua especialidade e criar templates personalizados.

## Suporte e Feedback

### Como obter ajuda se tiver problemas?
Você pode:
- Consultar esta documentação
- Acessar o fórum da comunidade em [community.prescreve.ai](https://community.prescreve.ai)
- Enviar email para suporte@prescreve.ai
- Usar o chat de suporte dentro do aplicativo

### Como sugerir novas funcionalidades?
Envie suas sugestões através do formulário em [prescreve.ai/sugestoes](https://prescreve.ai/sugestoes) ou vote em ideias existentes no nosso portal de feedback.

### Existe uma comunidade de usuários?
Sim, temos um fórum ativo em [community.prescreve.ai](https://community.prescreve.ai) onde médicos compartilham templates, dicas e melhores práticas.
EOT
)

# ===== Create all directories =====
mkdir -p docs/intro
mkdir -p docs/user-guide
mkdir -p docs/commands
mkdir -p docs/llm-integration
mkdir -p docs/customization
mkdir -p docs/api
mkdir -p docs/security
mkdir -p docs/faq
mkdir -p docs/assets

# ===== Create all files =====
# Intro section
create_markdown_file "docs/intro/index.md" "Visão Geral" "Introdução ao prescreve.ai e suas funcionalidades" 1 "$intro_index_content"
create_markdown_file "docs/intro/quickstart.md" "Início Rápido" "Guia para começar a usar o prescreve.ai rapidamente" 2 "$intro_quickstart_content"
create_markdown_file "docs/intro/architecture.md" "Arquitetura" "Visão detalhada da arquitetura do sistema" 3 "$intro_architecture_content"

# User Guide section
create_markdown_file "docs/user-guide/interface.md" "Interface do Aplicativo" "Guia da interface do usuário do prescreve.ai" 1 "$user_guide_interface_content"
create_markdown_file "docs/user-guide/workflows.md" "Fluxos de Trabalho" "Fluxos de trabalho comuns no prescreve.ai" 2 "$user_guide_workflows_content"
create_markdown_file "docs/user-guide/tips-tricks.md" "Dicas e Truques" "Dicas avançadas para usar o prescreve.ai" 3 "$user_guide_tips_content"

# Commands section
create_markdown_file "docs/commands/index.md" "Comandos" "Visão geral dos comandos do prescreve.ai" 1 "$commands_index_content"
create_markdown_file "docs/commands/prescrever.md" "Comando prescrever" "Como usar o comando prescrever para medicações" 2 "$commands_prescrever_content"
create_markdown_file "docs/commands/solicitar.md" "Comando solicitar" "Como usar o comando solicitar para exames" 3 "$commands_solicitar_content"
create_markdown_file "docs/commands/encaminhar.md" "Comando encaminhar" "Como usar o comando encaminhar para especialistas" 4 "$commands_encaminhar_content"

# LLM Integration section
create_markdown_file "docs/llm-integration/setup.md" "Configurando o LLM" "Como configurar o modelo de linguagem local" 1 "$llm_setup_content"
create_markdown_file "docs/llm-integration/prompting.md" "Otimização de Prompts" "Técnicas para otimizar prompts e obter melhores resultados" 2 "$llm_prompting_content"
create_markdown_file "docs/llm-integration/training.md" "Treinamento Específico" "Como treinar o modelo para terminologia médica" 3 "$llm_training_content"

# Customization section
create_markdown_file "docs/customization/templates.md" "Templates Personalizados" "Como criar e gerenciar templates personalizados" 1 "$customization_templates_content"

# API section
create_markdown_file "docs/api/endpoints.md" "API Endpoints" "Documentação dos endpoints da API do prescreve.ai" 1 "$api_endpoints_content"

# Security section
create_markdown_file "docs/security/privacy.md" "Segurança e Privacidade" "Medidas de segurança e privacidade do prescreve.ai" 1 "$security_privacy_content"

# FAQ section
create_markdown_file "docs/faq/index.md" "Perguntas Frequentes" "Respostas para dúvidas comuns sobre o prescreve.ai" 1 "$faq_content"

# Create docusaurus config files
cat > docusaurus.config.js << 'EOT'
// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

const lightCodeTheme = require('prism-react-renderer/themes/github');
const darkCodeTheme = require('prism-react-renderer/themes/dracula');

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: 'prescreve.ai',
  tagline: 'Prescrições, exames e encaminhamentos com linguagem natural',
  favicon: 'img/favicon.ico',

  // Set the production url of your site here
  url: 'https://docs.prescreve.ai',
  // Set the /<baseUrl>/ pathname under which your site is served
  // For GitHub pages deployment, it is often '/<projectName>/'
  baseUrl: '/',

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: 'prescreve-ai', // Usually your GitHub org/user name.
  projectName: 'prescreve-ai-docs', // Usually your repo name.

  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',

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
          sidebarPath: require.resolve('./sidebars.js'),
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            'https://github.com/prescreve-ai/prescreve-ai-docs/tree/main/',
        },
        blog: {
          showReadingTime: true,
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            'https://github.com/prescreve-ai/prescreve-ai-docs/tree/main/',
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
            href: 'https://github.com/prescreve-ai/prescreve-ai',
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
                to: '/docs/intro',
              },
              {
                label: 'Guia Rápido',
                to: '/docs/intro/quickstart',
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
                href: 'https://github.com/prescreve-ai/prescreve-ai',
              },
            ],
          },
        ],
        copyright: `Copyright © ${new Date().getFullYear()} prescreve.ai. Construído com Docusaurus.`,
      },
      prism: {
        theme: lightCodeTheme,
        darkTheme: darkCodeTheme,
      },
    }),
};

module.exports = config;
EOT

cat > sidebars.js << 'EOT'
/**
 * Creating a sidebar enables you to:
 - create an ordered group of docs
 - render a sidebar for each doc of that group
 - provide next/previous navigation

 The sidebars can be generated from the filesystem, or explicitly defined here.

 Create as many sidebars as you want.
 */

// @ts-check

/** @type {import('@docusaurus/plugin-content-docs').SidebarsConfig} */
const sidebars = {
  // By default, Docusaurus generates a sidebar from the docs folder structure
  tutorialSidebar: [{type: 'autogenerated', dirName: '.'}],
};

module.exports = sidebars;
EOT

# Create placeholder files
touch docs/assets/.gitkeep

# Setup script for Docusaurus
cat > setup_docusaurus.sh << 'EOT'
#!/bin/bash

# Script para configurar o Docusaurus para a documentação do prescreve.ai

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

# Criar projeto Docusaurus
echo "📦 Criando projeto Docusaurus..."
npx create-docusaurus@latest . classic --typescript

# Copiar arquivos de documentação para a pasta docs
echo "📋 Copiando arquivos de documentação..."
cp -r docs/* docs/

# Instalar dependências
echo "📚 Instalando dependências..."
npm install

# Iniciar servidor de desenvolvimento
echo "✅ Configuração concluída!"
echo ""
echo "Para iniciar o servidor de desenvolvimento, execute:"
echo "npm start"
echo ""
echo "Para construir a documentação estática, execute:"
echo "npm run build"
EOT

chmod +x setup_docusaurus.sh

echo "✅ Estrutura de documentação criada com sucesso!"
echo "✅ Total de arquivos criados: $(find docs -type f | wc -l)"
echo ""
echo "Para configurar o Docusaurus, execute:"
echo "./setup_docusaurus.sh"
echo ""
echo "Boa documentação! 📚"