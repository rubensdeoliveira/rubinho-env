# Anotações de Monorepo

## Passo 1
Rodar no terminal na raiz:

```yarn init -y```

## Passo 2
Adicionar em
package.json
as tags:

```
"private": "true",
"workspaces": {
  "packages": [
    "packages/*",
    "packages/shared/*"
  ],
  "nohoist": [
    "**/jest",
    "**/ts-jest"
  ]
},
```

## Passo 3
Criar pasta
packages

## Passo 4
Criar arquivo
.gitignore

## Passo 5
Dentro de
.gitignore
colocar:

```
node_modules
dist
yarn-error.log
```

## Passo 6
Na raiz do projeto rodar no terminal:

```yarn add typescript -DW```

## Passo 7
Criar pasta
packages > shared > eslint-config

## Passo 8
Dentro de 
packages > shared > eslint-config
rodar no terminal:

```yarn init -y```

## Passo 11
Trocar nome do projeto para
@NOME_DO_PROJETO/eslint-config
em
packages > shared > eslint-config > package.json

## Passo 12
Dentro de
packages > shared > eslint-config
Rodar no terminal os seguintes comandos:

`yarn add @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint@6.8.0 eslint-config-prettier eslint-config-standard eslint-import-resolver-typescript eslint-plugin-import eslint-plugin-node eslint-plugin-prettier eslint-plugin-promise eslint-plugin-react eslint-plugin-standard prettier -D`

## Passo 13
Dentro de
packages > shared > eslint-config
rodar no terminal:

`yarn`

## Passo 14
Criar arquivo
Dentro de
packages > eslint-config > .eslintrc.js

## Passo 15
Dentro de
packages > eslint-config > .eslintrc.js
colocar:

```
module.exports = {
  env: {
    browser: true,
    es2020: true,
    node: true,
    jest: true
  },
  extends: [
    'plugin:react/recommended',
    'standard',
    'plugin:@typescript-eslint/recommended',
    'prettier/@typescript-eslint',
    'prettier/standard',
    'prettier/react'
  ],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaFeatures: {
      jsx: true
    },
    ecmaVersion: 11,
    sourceType: 'module'
  },
  plugins: ['react', '@typescript-eslint', 'prettier', 'react-hooks'],
  rules: {
    'prettier/prettier': 'error',
    '@typescript-eslint/ban-types': 'off',
    'space-before-function-paren': ['error', 'never'],
    'no-useless-constructor': 'off',
    '@typescript-eslint/no-useless-constructor': ['error'],
    'react/prop-types': 'off',
    'space-before-function-paren': 'off',
    'react-hooks/rules-of-hooks': 'error',
    'react-hooks/exhaustive-deps': 'warn',
    'no-unused-expressions': 'off',
    '@typescript-eslint/interface-name-prefix': [
      'error',
      { 'prefixWithI': 'always' }
    ],
    '@typescript-eslint/no-unused-vars': [
      'error',
      {
        'argsIgnorePattern': '_'
      }
    ],
    '@typescript-eslint/explicit-function-return-type': [
      'error',
      {
        'allowExpressions': true
      }
    ],
  },
  settings: {
    'import/resolver': {
      typescript: {}
    },
    react: {
      version: 'detect'
    }
  }
}
```

## Passo 16
Dentro de
packages > eslint-config > package.json
alterar a tag main para:

`"main": ".eslintrc.js",`

## Passo 17
Criar arquivo
prettier.config.js
na raiz do projeto mesmo

## Passo 18
dentro de
prettier.config.js
colocar:

```
module.exports = {
  semi: false,
  singleQuote: true,
  arrowParens: 'avoid',
  trailingComma: 'none',
  endOfLine: 'auto'
}
```

## Passo 19
Criar arquivo
.eslintrc.js
na raiz do projeto

## Passo 20
Dentro de 
package.json
adicionar na tag devDependecies o projeto eslint-config.
Vai ficar mais ou menos assim:

```
"devDependencies": {
  "typescript": "^4.0.2",
  "@NOME_DO_PROJETO/eslint-config": "*"
}
```

## Passo 21
Na raiz do projeto rodar no terminal:

`yarn`

## Passo 22
Dentro de
.eslintrc.js
colocar:

```
const config = require('@NOME_DO_PROJETO/eslint-config')

module.exports = config
```

## Passo 23
Criar arquivo
.eslintignore
na raiz do projeto

## Passo 24
Dentro de
.eslintignore
colocar:

```
.eslintrc.js
packages/**/*.js
node_modules
dist
```

## Passo 25
Criar arquivo
tsconfig.json

## Passo 26
Dentro de 
tsconfig.json
adicionar:

```
{
  "compilerOptions": {
    "target": "es2017",
    "module": "commonjs",
    "noEmit": true,
    "resolveJsonModule": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  }
}
```

## Passo 28
Configure os projetos separadamente acessando os links abaixo:

[server](monorepo-express.md)
[ReactJS](monorepo-react.md)
[Next](monorepo-next.md)
[React Native](monorepo-react-native.md)

caso precise do axios ou de testes com jest volte para esse tutorial para continuar os próximos passos.

## Passo 29
Criar pasta
packages > shared > axios-config

## Passo 30
Dentro de 
packages > shared > axios-config
rodar no terminal:

```yarn init -y```

## Passo 31
Dentro de 
packages > shared > axios-config > package.json
alterar nome do projeto para
@NOME_DO_PROJETO/axios-config

## Passo 32
Criar arquivo
packages > shared > axios-config > index.ts

## Passo 33
Dentro de 
packages > shared > axios-config > index.ts
colocar:

```
import axios from 'axios'

const api = axios.create({
  baseURL: 'http://localhost:3333'
})

export default api

```

# Passo 34
Dentro de 
packages > shared > axios-config > package.json
alterar tag main para:

```"main": "index.ts",```

## Passo 35
na raiz do projeto rodar no terminal:

```yarn add @types/jest -DW```