---
title: Templates Personalizados
sidebar_position: 1
description: Como criar e gerenciar templates personalizados
---

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
