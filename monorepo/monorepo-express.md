# Anotações - Monorepo com Express (Arquitetura Simples)

## Criar pasta server

  ```bash
    # Abrir pasta packages
    $ cd packages
    # Criar pasta server
    $ mkdir server
    # Execute
    $ yarn init -y
  ```
## Alterar nome do projeto no package.json
  ```bash
    # Dentro de packages/sever
    $ cd packages/server
    # No arquivo package.json altere o nome do projeto para:
    @NOME_DO_PROJETO/server
  ```

## Criar arquivo .gitignore
  ```bash
    # Dentro de packages/sever
    $ cd packages/server
    # Criar arquivo .gitignore
    .gitignore 
  ```

## Procurar um gitignore para node
Site: [gitignore.io](https://www.toptal.com/developers/gitignore)
Colar no arquivo criado acima

## Adcionar express
  ```bash
    # Dentro de packages/server
    $ cd packages/server
    # Execute
    $ yarn add express
  ```
## Criar arquivo tsconfig.json
  ```bash
    # Dentro de packages/server
    $ cd packages/server
    # Execute
    $ yarn tsc --init
  ```


## Alterar conteúdo do tsconfig.json
```bash
  # Dentro de packages/server
  $ cd packages/server

  # Abrir arquivo tsconfing.json e alterar todo o conteúdo para:

  {
    "extends": "../../tsconfig.json",
    "compilerOptions": {
      "outDir": "./dist",                        
      "rootDir": "./src",  
    },
    "include": ["./src/**/*"]
  }
```

## Criar pasta src
```bash
  # Dentro de packages/server
  $ cd packages/server
  # Criar pasta src
  $ mkdir src
```
## Criar arquivo server.ts
```bash
  # Dentro de packages/server/src
  $ cd packages/server/src
  # criar arquivo
  server.ts
```

## Colocando conteúdo dentro do arquivo server.ts
```bash
  # Dentro de packages/server/src
  $ cd packages/server/src

  # Abra arquivo server.ts e coloque:

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

## Adicionar dependêcia
```bash
  # Dentro de packages/server
  $ cd packages/server
  # Execute
  $ yarn add @types/express ts-node-dev -D
```

## Adicionar cors
```bash
  # Dentro de packages/server
  $ cd packages/server
  # Execute
  $ yarn add cors
```

## Adicionar dependêcia
```bash
  # Dentro de packages/server
  $ cd packages/server
  # Execute
  $ yarn add @types/cors -D
```

## Colocar tag no package.json
```bash
  # Dentro de packages/server
  $ cd packages/server

  # Abra arquivo package.json e adicione a tag:

  "scripts": {
    "build": "tsc",
    "dev:server": "ts-node-dev --inspect --transpile-only --ignore-watch node_modules src/server.ts"
  }, 
```
**Obs: é bom digitar manualmente porque copiando dá problema.**

## Rodar a aplicação
```bash
  # Dentro de packages/server
  $ cd packages/server
  # Execute 
  $ yarn dev:server
```
**Faça isso para testar se tudo está ok**

## Criar arquivo server/index.ts
```bash
  # Dentro de packages/server
  $ cd packages/server
  # Criar pasta routes
  $ mkdir routes
  $ cd routes
  Criar arquivo index.ts
```

## Colocar conteúdo dentro do server/index.ts
```bash
  # Dentro de packages/server/src/routes
  $ cd packages/server/src/routes

  # Abra o arquivo index.ts e coloque:

  import { Router } from 'express'

  const routes = Router()

  routes.get('/', (request, response) =>
    response.json({ message: 'Hello World' })
  )

  export default routes
```

## Substituir conteúdo de server.ts
```bash
  # Dentro de packages/server/src
  $ cd packages/server/src

  # Abra o arquivo server.ts e altere o conteúdo por:

  import express from 'express'
  import cors from 'cors'
  import routes from './routes'

  const app = express()

  app.use(cors())
  app.use(express.json())

  app.use(routes)

  app.listen(3333, () => {
    console.log('Server stated on port 3333')
  })
```

## Criar arquivo ormconfig.json
```bash
  #Dentro de packages/server 
  $ cd packages/server

  Crie arquivo ormconfig.json
```

## Adicionar typeorm
```bash
  #Dentro de packages/server 
  $ cd packages/server
  # Execute
  $ yarn add typeorm pg
```


## Colocar conteúdo no server/ormconfig.json
```bash
  #Dentro de packages/server 
  $ cd packages/server

  Abra o arquivo ormconfig.json e coloque:

  {
    "type": "postgres",
    "host": "localhost",
    "port": 5432,
    "username": "postgres",
    "password": "docker",
    "database": "dbname"
  }
```
## Criar pasta database e criar arquivo index.ts dentro
```bash
  # Dentro de packages/server/src
  $ cd packages/server/src
  # Criar pasta database
  $ mkdir database
  $ cd database
  Criar arquivo index.ts
```

## Colocar conteúdo no arquivo database/index.ts
```bash
  # Dentro de packages/server/src/database
  $ cd packages/server/src/database

  # Abrir arquivo index.ts e colocar:

  import { createConnection } from 'typeorm'

  createConnection()
```

## Importar database
```bash
  # Dentro de packages/server/src
  $ cd packages/server/src

  # Abrir arquivo server.ts e adicionar:

  import './database'
```
**Após a importação de routes**

## Adicionar elementos no array de nohois
Dentro de package.json

Adicionar dentro do array de nohoist os dois elementos abaixo:

```bash
"**/typeorm/**",
"**/typeorm"
```

## Rodar o servidor
Rode o servidor para ver se está tudo ok, agora que foi adicionado o banco

## Criar pasta migrations
```bash
  #Dentro de packages/server/src/database
  $ cd packages/server/src/database
  # Criar pasta migrations
  $ mkdir migrations
```

## Alterar conteúdo do arquivo server/ormconfig.json
```bash
  #Dentro de packages/server
  $ cd packages/server
  
  # Abra arquivo ormconfig.json e altere o conteúdo para:

  {
    "type": "postgres",
    "host": "localhost",
    "port": 5432,
    "username": "postgres",
    "password": "docker",
    "database": "sampleprojectdb",
    "entities": ["./src/models/*.ts"],
    "migrations": ["./src/database/migrations/*.ts"],
    "cli": {
      "migrationsDir": "./src/database/migrations"
    }
  }
```

## Alterar conteúdo do arquivo tsconfig.json
```bash
  # Dentro de packages/server
  $ cd packages/server

  # Abra o arquivo tsconfig.json e altere o conteúdo para:

  {
    "extends": "../../tsconfig.json",
    "compilerOptions": {
      "outDir": "./dist",                        
      "rootDir": "./src",  
      "experimentalDecorators": true,
      "emitDecoratorMetadata": true,
      "strictPropertyInitialization": false
    },
    "include": ["./src/**/*"]
  }
```

## Criar pasta models
```bash
  # Dentro packages/server/src
  $ cd packages/server/src
  # Criar pasta models
  $ mkdir models
```

## Criar arquivo models/User.ts
```bash
  # Dentro de packages/server/src/models
  $ cd packages/server/src/models 
  Criar aquivo User.ts

  # Coloque dentro:

  import {
    Entity,
    Column,
    PrimaryGeneratedColumn,
    CreateDateColumn,
    UpdateDateColumn
  } from 'typeorm'

  @Entity('users')
  class User {
    @PrimaryGeneratedColumn('uuid')
    id: string

    @Column()
    name: string

    @Column()
    email: string

    @Column()
    password: string

    @CreateDateColumn()
    created_at: Date

    @UpdateDateColumn()
    updated_at: Date
  }

  export default User
```

## Adicionar script no arquivo package.json
```bash
  # Dentro de packages/server
  $ cd packages/server
  
  # Abra o arquivo package.json

  A tag scripts vai ficar assim:

  "scripts": {
    "build": "tsc",
    "dev:server": "ts-node-dev --inspect --transpile-only --ignore-watch node_modules src/server.ts",
    "typeorm": "ts-node-dev ./node_modules/typeorm/cli.js"  
  },
```

## Criar migration de Users
```bash
  #Dentro de packages/server
  $ cd packages/server
  # Execute 
  $ yarn typeorm migration:create -n CreateUsers
```

## Alterar métodos up e down
```bash
  # Dentro de packages/serversrc/database/migrations
  $ cd packages/serversrc/database/migrations

  # Alterar métodos up e down por:

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: 'users',
        columns: [
          {
            name: 'id',
            type: 'uuid',
            isPrimary: true,
            generationStrategy: 'uuid',
            default: 'uuid_generate_v4()'
          },
          {
            name: 'name',
            type: 'varchar',
            isNullable: false
          },
          {
            name: 'email',
            type: 'varchar',
            isNullable: false,
            isUnique: true
          },
          {
            name: 'password',
            type: 'varchar',
            isNullable: false
          },
          {
            name: 'created_at',
            type: 'timestamp',
            default: 'now()'
          },
          {
            name: 'updated_at',
            type: 'timestamp',
            default: 'now()'
          }
        ]
      })
    )
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropTable('users')
  }
```

## Rodar migration
```bash
  # Dentro de packages/server
  $ cd packages/server
  # Execute 
  $ yarn typeorm migration:run
```

## Instalar reflect-metadata
```bash
  # Dentro de packages/server
  $ cd packages/server
  # Execute 
  $ yarn add reflect-metadata
```

## Importar o reflect-metadata no arquivo server.ts
```bash
  # Dentro de packages/server/src
  $ cd packages/server/src

  Abra o arquivo server.ts e adicione no começo da linha:
  import 'reflect-metadata'

  
  
```


## Alterar todo o conteúdo de routes/index.ts
```bash
  # Dentro de packages/server/src/routes
  $ cd packages/server/src/routes

  Abra o arquivo index.ts e troque todo o conteúdo por:

  import { Router } from 'express'
  import usersRouter from './users.routes'

  const routes = Router()
  routes.use('/users', usersRouter)

  export default routes
```

## Criar arquivo routes/users.routes.ts
```Bash
  #Dentro de packages/server/src/routes
  $ cd packages/server/src/routes

  Criar arquivo users.routes.ts e dentro colocar:

  import { Router } from 'express'

  import CreateUserService from '../services/CreateUserService'

  const usersRouter = Router()

  usersRouter.post('/', async (request, response) => {
    try {
      const { name, email, password } = request.body

      const createUser = new CreateUserService()

      const user = await createUser.execute({
        name,
        email,
        password
      })

      delete user.password

      return response.json(user)
    } catch (err) {
      return response.status(400).json({ error: err.message })
    }
  })

  export default usersRouter
```

## Criar arquivo services/CreateUserService.ts
```Bash
  # Dentro de packages/server/src/services
  $ cd packages/server/src/services

  Criar arquivo CreateUserService.ts e dentro colocar:


  import { getRepository } from 'typeorm'

  import { hash } from 'bcryptjs'

  import User from '../models/User'

  interface Request {
    name: string
    email: string
    password: string
  }

  class CreateUserService {
    public async execute({ name, email, password }: Request): Promise<User> {
      const usersRepository = getRepository(User)

      const checkUserExists = await usersRepository.findOne({
        where: { email }
      })

      if (checkUserExists) {
        throw new Error(
          'E-mail já existente na base de dados, tente outro e-mail.'
        )
      }

      const hashedPassword = await hash(password, 8)

      const user = usersRepository.create({
        name,
        email,
        password: hashedPassword
      })

      await usersRepository.save(user)

      return user
    }
  }

  export default CreateUserService
```

## Rodar quatro comandos
```bash
  # Dentro de packages/server
  $ cd packages/server

  # Execute:
  $ yarn add bcryptjs
  $ yarn add @types/bcryptjs -D
  $ yarn add jsonwebtoken
  $ yarn add @types/jsonwebtoken -D
```

## Acessar link 
Acesso o [link](http://www.md5.cz/) e gere um código, salve esse código


## Criar arquivo routes/sessions.routes.ts
```bash
  # Dentro de packages/server/src/routes
  $ cd packages/server/src/routes

  Criar arquivo sessions.routes.ts e dentro colocar:


  import { Router } from 'express'

  import AuthenticateUserService from '../services/AuthenticateUserService'

  const sessionsRouter = Router()

  sessionsRouter.post('/', async (request, response) => {
    try {
      const { email, password } = request.body

      const authenticateUser = new AuthenticateUserService()

      const { user, token } = await authenticateUser.execute({
        email,
        password
      })

      delete user.password

      return response.json({ user, token })
    } catch (err) {
      return response.status(400).json({ error: err.message })
    }
  })

  export default sessionsRouter
```

## Criar arquivo services/AuthenticateUserService.ts
```bash
  # Dentro de packages/server/src/services
  $ cd packages/server/src/services
  
  Criar arquivo AuthenticateUserService.ts e dentro colocar:


  import { getRepository } from 'typeorm'
  import { compare } from 'bcryptjs'
  import { sign } from 'jsonwebtoken'

  import User from '../models/User'

  interface Request {
    email: string
    password: string
  }

  interface Response {
    user: User
    token: string
  }

  class AuthenticateUserService {
    public async execute({ email, password }: Request): Promise<Response> {
      const usersRepository = getRepository(User)

      const user = await usersRepository.findOne({ where: { email } })

      if (!user) {
        throw new Error('Combinação de email/senha inválida.')
      }

      const passwordMatched = await compare(password, user.password)

      if (!passwordMatched) {
        throw new Error('Combinação de email/senha inválida.')
      }

      const token = sign({}, 'caa9c8f8620cbb30679026bb6427e11f', {
        subject: user.id,
        expiresIn: '1d'
      })

      return {
        user,
        token
      }
    }
  }

  export default AuthenticateUserService
```

# Alterar conteúdo do arquivo routes/index.ts
```bash
  # Dentro de packages/server/src/routes
  $ cd packages/server/src/routes

  Trocar conteúdo por:

  import { Router } from 'express'
  import sessionsRouter from './sessions.routes'
  import usersRouter from './users.routes'

  const routes = Router()

  routes.use('/users', usersRouter)
  routes.use('/sessions', sessionsRouter)

  export default routes
```