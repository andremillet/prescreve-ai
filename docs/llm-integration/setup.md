---
title: Configurando o LLM
sidebar_position: 1
description: Como configurar o modelo de linguagem local
---

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
