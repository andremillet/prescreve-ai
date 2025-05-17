---
title: Segurança e Privacidade
sidebar_position: 1
description: Medidas de segurança e privacidade do prescreve.ai
---

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
