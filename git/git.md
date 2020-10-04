# Anotações de Git

## Adicionar usuário e e-mail na config global

`git config --global user.name "Fulano de Tal"`

`git config --global user.email fulanodetal@exemplo.br`

## Salvar dados do usuário github definitivamente

`git config --global credential.helper cache`
>Esse comando permite que o usuário github fique salvo e, assim, não fique solicitando sempre o usuário e senha para fazer commits.

## Remover arquivo do controle de versão

`git rm --cached NOME_DO_ARQUIVO`
>Alterar **NOME_DO_ARQUIVO** por arquivo desejado.

## Criar branch

`git checkout -b NOME_DO_BRANCH`
>Alterar **NOME_DO_BRANCH** por nome do branch desejado.