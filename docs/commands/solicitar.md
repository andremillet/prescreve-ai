---
title: Comando solicitar
sidebar_position: 3
description: Como usar o comando solicitar para exames
---

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
