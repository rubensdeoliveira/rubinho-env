# Anotações de Monorepo com Next.js

## ...
Dentro de
packages
rodar no terminal:

`yarn create next-app web`

## ...
Dentro de
packages > web
rodar no terminal:

`yarn add typescript @types/react @types/node -D`

## ...
Dentro de
packages > web
deletar readme.md

## ...
Dentro de
packages > web
deletar pasta 
packages > web > styles

## ...
Dentro de
packages > web > public
deletar os dois arquivos de imagem

## ...
Dentro de
packages > web > pages
deletar a pasta api

## ...
Criar pasta
packages > web > src
e mover pasta pages para dentro
fica assim:
packages > web > src > pages

## ...
Dentro de
packages > web
rodar no terminal:

`yarn add styled-components`

## ...
Dentro de
packages > web
rodar no terminal:

`yarn add @types/styled-components -D`

## ...
Criar pasta
packages > web > src > styles

## ...
Criar arquivo
packages > web > src > styles > GlobalStyle.ts
e dentro colocar:

```
import { createGlobalStyle } from 'styled-components'

export const GlobalStyle = createGlobalStyle`
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    outline: 0;
  }

  :root {
    font-size: 62.5%;
    --primary-color: #00b3b4;
    --secondary-color: #0078b5;
    --contrast-color: #fff;
    --error-color: #c53030;
  }
 
  body {
    background: var(--primary-color);
    color: var(--font-color);
    -webkit-font-smoothing: antialiased;
  }

  body, input, button {
    font-family: 'Roboto', sans-serif;
    font-size: 1.6rem;
  }

  button {
    cursor: pointer;
  }
`
```

## ...

## ...

## ...

## ...