---
title: Comando encaminhar
sidebar_position: 4
description: Como usar o comando encaminhar para especialistas
---

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
