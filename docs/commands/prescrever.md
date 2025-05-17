---
title: Comando prescrever
sidebar_position: 2
description: Como usar o comando prescrever para medicações
---

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
