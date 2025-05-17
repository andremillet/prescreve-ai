# Implantação no GitHub Pages

Este documento explica como a documentação do prescreve.ai está configurada para implantação automática no GitHub Pages.

## Configuração Atual

A documentação está configurada para ser implantada automaticamente no GitHub Pages quando ocorrerem alterações em arquivos relevantes no branch principal. O processo de implantação é gerenciado pelo GitHub Actions.

## Fluxo de Implantação

1. Quando você envia alterações para o branch principal (`main`), o workflow do GitHub Actions é acionado
2. O GitHub Actions constrói o site usando Docusaurus
3. O site construído é implantado no branch `gh-pages`
4. O GitHub Pages serve o conteúdo a partir deste branch

## Implantação Manual

Você também pode acionar a implantação manualmente:

1. No GitHub, vá para a guia "Actions" do seu repositório
2. Selecione o workflow "Deploy Documentation to GitHub Pages"
3. Clique no botão "Run workflow"
4. Selecione o branch "main" e confirme

## Alterando a Configuração

Se você precisar alterar a configuração de implantação:

1. Edite o arquivo `.github/workflows/documentation.yml` para modificar o workflow do GitHub Actions
2. Edite o arquivo `docusaurus.config.js` para modificar configurações específicas do Docusaurus para o GitHub Pages

## Domínio Personalizado

Para usar um domínio personalizado com seu site do GitHub Pages:

1. No GitHub, vá para "Settings" > "Pages"
2. Na seção "Custom domain", digite seu domínio personalizado (ex: docs.prescreve.ai)
3. Clique em "Save"
4. Adicione um arquivo CNAME à pasta `static/` do seu projeto com o nome do domínio
5. Configure seu DNS conforme as instruções do GitHub

## Solução de Problemas

Se a implantação falhar:

1. Verifique os logs na guia "Actions" do GitHub
2. Confirme se as dependências estão instaladas corretamente
3. Verifique se o repositório tem as permissões corretas para o GitHub Actions

Para mais detalhes, consulte a [documentação do Docusaurus sobre implantação](https://docusaurus.io/docs/deployment#deploying-to-github-pages).
