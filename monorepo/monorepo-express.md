# Anotações - Monorepo com Express (Arquitetura Simples)

## Passo 1
criar pasta 
packages > server
e dentro de
packages > server
rodar no terminal:

`yarn init -y`

## Passo 16
Dentro de 
packages > server > package.json
alterar o nome do projeto para 
@NOME_DO_PROJETO/server

## Passo 2
Dentro de
packages > server
criar arquivo 
.gitignore

## Passo 3
Procurar um gitignore para node na internet e colar no arquivo criado acima

## Passo 4
Dentro de
packages > server
rodar no terminal:

`yarn add express`

## Passo 6
Dentro de
packages > server
rodar no terminal:

`yarn tsc --init`

## Passo 71
Dentro de
packages > server > tsconfig.json
alterar todo o conteúdo para:

```
{
  "extends": "../../tsconfig.json",
  "compilerOptions": {
    "outDir": "./dist",                        
    "rootDir": "./src",  
  },
  "include": ["./src/**/*"]
}
```

## Passo 7
Criar pasta
packages > server > src

## Passo 8
Criar arquivo
packages > server > src > server.ts

## Passo 9
Dentro de
packages > server > src > server.ts
colocar:

```
import express from 'express'
import cors from 'cors'

const app = express();

app.use(cors())

app.get("/", (request, response) => {
  return response.json({ message: "Hello World" });
});

app.listen(3333, () => {
  console.log("Server stated on port 3333");
});
```

## Passo 11
Dentro de 
packages > server
rodar no terminal: 

`yarn add @types/express ts-node-dev -D`

## Passo 12
Dentro de 
packages > server
rodar: 

`yarn add cors`

## Passo 13
Dentro de 
packages > server
rodar: 

`yarn add @types/cors -D`

## Passo 14
Dentro de 
packages > server > package.json
adicionar tag:

```
"scripts": {
  "build": "tsc",
  "dev:server": "ts-node-dev --inspect --transpile-only --ignore-watch node_modules src/server.ts"
}, 
```

Obs: é bom digitar manualmente porque copiando dá problema.

## Passo 15
Rode a aplicação com

`yarn dev:server`

dentro de 
packages > server
para testar se tudo está ok



