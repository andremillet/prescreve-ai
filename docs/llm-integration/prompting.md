---
title: Otimização de Prompts
sidebar_position: 2
description: Técnicas para otimizar prompts e obter melhores resultados
---

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
