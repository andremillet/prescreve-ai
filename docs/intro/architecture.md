---
title: Arquitetura
sidebar_position: 3
description: Visão detalhada da arquitetura do sistema
---

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
