---
title: API Endpoints
sidebar_position: 1
description: Documentação dos endpoints da API do prescreve.ai
---

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
