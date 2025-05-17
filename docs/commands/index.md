---
title: Comandos
sidebar_position: 1
description: Visão geral dos comandos do prescreve.ai
---

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
