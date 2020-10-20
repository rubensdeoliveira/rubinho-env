# Anotações - Monorepo com Express (Arquitetura Complexa)

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

## Adicionar elementos no array de nohois
Dentro de package.json

Adicionar dentro do array de nohoist os dois elementos abaixo:

```bash
"**/typeorm/**",
"**/typeorm"
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

## ...
Criar pasta
packages > server > src > modules

## ...
Criar pasta
packages > server > src > modules > users

## ...
Criar pasta
packages > server > src > shared

## ...
Criar pasta
packages > server > src > shared > infra

## ...
Criar pasta
packages > server > src > shared > errors

## ...
Criar arquivo
packages > server > src > shared > errors > AppError.ts
e dentro colocar:

```
class AppError {
  public readonly message: string

  public readonly statusCode: number

  constructor(message: string, statusCode = 400) {
    this.message = message
    this.statusCode = statusCode
  }
}

export default AppError
```

## ...
Criar pasta
packages > server > src > shared > infra > http

## ...
Mover arquivo server.ts para dentro de 
packages > server > src > shared > infra > http
fica assim:
packages > server > src > shared > infra > http > server.ts

## ...
Alterar arquivo
tsconfig.json

```
{
  "extends": "../../tsconfig.json",
  "compilerOptions": {
    "baseUrl": "./src",
    "outDir": "./dist",                        
    "rootDir": "./src",  
    "experimentalDecorators": true,
    "emitDecoratorMetadata": true,
    "strictPropertyInitialization": false,
    "allowJs": true,
    "paths": {
      "@modules/*": ["modules/*"],
      "@config/*": ["config/*"],
      "@shared/*": ["shared/*"]
    },
  },
  "include": ["./src/**/*"]
}
```

## ...
Dentro de packages > server
dentro de terminal rodar:

`yarn add tsconfig-paths -D`

## ...
Alterar tag scripts de
packages > server > package.json
para:

```
"scripts": {
  "build": "tsc",
  "dev:server": "ts-node-dev -r tsconfig-paths/register --inspect --transpile-only --ignore-watch node_modules src/shared/infra/http/server.ts",
  "typeorm": "ts-node-dev -r tsconfig-paths/register ./node_modules/typeorm/cli.js",
  "test": "jest"
},
```

## ...
Criar pasta
packages > server > src > modules > users > infra

## ...
Criar pasta
packages > server > src > modules > users > repositories

## ...
Criar pasta
packages > server > src > modules > users > services

## ...
Criar pasta
packages > server > src > modules > users > dtos

## ...
Criar pasta
packages > server > src > modules > users > infra > http

## ...
Criar pasta
packages > server > src > modules > users > infra > http > routes

## ...
Criar arquivo
packages > server > src > modules > users > infra > http > routes > users.routes.ts
e dentro colocar:

```
import { Router } from 'express'
import { celebrate, Segments, Joi } from 'celebrate'

import multer from 'multer'
import uploadConfig from '@config/upload'

import UsersController from '../controllers/UsersController'
import UserAvatarController from '../controllers/UserAvatarController'

import ensureAuthenticated from '../middlewares/ensureAuthenticated'

const usersRouter = Router()
const usersController = new UsersController()
const userAvatarController = new UserAvatarController()
const upload = multer(uploadConfig)

usersRouter.post(
  '/',
  celebrate({
    [Segments.BODY]: {
      name: Joi.string().required(),
      email: Joi.string().email().required(),
      password: Joi.string().required(),
    },
  }),
  usersController.create,
)

usersRouter.patch(
  '/avatar',
  ensureAuthenticated,
  upload.single('avatar'),
  userAvatarController.update,
)

export default usersRouter
```

## ...
rodar em
packages > server
no terminal:

`yarn add celebrate multer`

## ...
Criar pasta
packages > server > src > config

## ...
Criar Arquivo
packages > server > src > config > upload.ts
e dentro colocar: 

```
import multer from 'multer'
import path from 'path'
import crypto from 'crypto'

const tmpFolder = path.resolve(__dirname, '..', '..', 'tmp')

export default {
  tmpFolder,
  uploadsFolder: path.resolve(tmpFolder, 'uploads'),
  storage: multer.diskStorage({
    destination: tmpFolder,
    filename(request, file, callback) {
      const fileHash = crypto.randomBytes(10).toString('hex')
      const filename = `${fileHash}-${file.originalname}`

      return callback(null, filename)
    },
  }),
}
```

## ...
Criar pasta
packages > server > src > modules > users > infra > http > controllers

## ...
Criar Arquivo
packages > server > src > modules > users > infra > http > controllers > UsersController.ts
e dentro colocar:

```
import { Request, Response } from 'express'
import { container } from 'tsyringe'
import { classToClass } from 'class-transformer'

import CreateUserService from '@modules/users/services/CreateUserService'

export default class UsersController {
  public async create(request: Request, response: Response): Promise<Response> {
    const { name, email, password } = request.body

    const createUser = container.resolve(CreateUserService)

    const user = await createUser.execute({
      name,
      email,
      password,
    })

    delete user.password

    return response.json(classToClass(user))
  }
}
```

## ...
Criar Arquivo
packages > server > src > modules > users > infra > http > controllers > UserAvatarController.ts
e dentro colocar:

```
import { Request, Response } from 'express'
import { container } from 'tsyringe'
import { classToClass } from 'class-transformer'

import UpdateUserAvatarService from '@modules/users/services/UpdateUserAvatarService'

export default class UserAvatarController {
  public async update(request: Request, response: Response): Promise<Response> {
    const updateUserAvatar = container.resolve(UpdateUserAvatarService)

    const user = await updateUserAvatar.execute({
      user_id: request.user.id,
      avatarFilename: request.file.filename,
    })

    delete user.password

    return response.json(classToClass(user))
  }
}
```

## ...
dentro de
packages > server
rodar no terminal:

`yarn add class-transformer tsyringe`

## ...
Criar pasta
packages > server > src > modules > users > infra > http > middlewares

## ...
Criar arquivo
packages > server > src > modules > users > infra > http > middlewares > ensureAuthenticated.ts
e dentro colocar:

```
import { Request, Response, NextFunction } from 'express'
import { verify } from 'jsonwebtoken'

import authConfig from '@config/auth'

import AppError from '@shared/errors/AppError'

interface TokenPayload {
  iat: number
  exp: number
  sub: string
}

export default function ensureAuthenticated(
  request: Request,
  response: Response,
  next: NextFunction,
): void {
  const authHeader = request.headers.authorization

  if (!authHeader) {
    throw new AppError('JWT não foi enviado', 401)
  }

  const [, token] = authHeader.split(' ')

  try {
    const decoded = verify(token, authConfig.jwt.secret)

    const { sub } = decoded as TokenPayload

    request.user = { id: sub }

    return next()
  } catch {
    throw new AppError('JWT inválido', 401)
  }
}
```

## ...
dentro de
packages > server
rodar no terminal:

`yarn add jsonwebtoken`

## ...
Criar arquivo
packages > server > src > config > auth.ts
e dentro colocar:

```
export default {
  jwt: {
    secret: process.env.APP_SECRET || 'default',
    expiresIn: '1d',
  },
}
```

## ...
Criar arquivo
packages > server > .env
e dentro colocar:

```
APP_SECRET=
APP_WEB_URL=http://localhost:3000
APP_API_URL=http://localhost:3333
```

## ...
Criar arquivo
packages > server > .env.example
e dentro colocar:

```
APP_SECRET=
APP_WEB_URL=http://localhost:3000
APP_API_URL=http://localhost:3333
```

## ...
dentro de
packages > server
rodar no terminal:

`yarn add dotenv`

## ...
Criar pasta
packages > server > src > modules > users > services > CreateUserService.ts
e dentro colocar:

```
import { injectable, inject } from 'tsyringe'

import ICacheProvider from '@shared/container/providers/CacheProvider/models/ICacheProvider'

import AppError from '@shared/errors/AppError'
import IUsersRepository from '../repositories/IUsersRepository'
import IHashProvider from '../providers/HashProvider/models/IHashProvider'

import User from '../infra/typeorm/entities/User'

interface IRequest {
  name: string
  email: string
  password: string
}

@injectable()
class CreateUserService {
  constructor(
    @inject('UsersRepository')
    private usersRepository: IUsersRepository,

    @inject('HashProvider')
    private hashProvider: IHashProvider,

    @inject('CacheProvider')
    private cacheProvider: ICacheProvider,
  ) {}

  public async execute({ name, email, password }: IRequest): Promise<User> {
    const checkUserExists = await this.usersRepository.findByEmail(email)

    if (checkUserExists) {
      throw new AppError('O e-mail já existe na base de dados')
    }

    const hashedPassword = await this.hashProvider.generateHash(password)

    const user = await this.usersRepository.create({
      name,
      email,
      password: hashedPassword,
    })

    await this.cacheProvider.invalidatePrefix('providers-list')

    return user
  }
}

export default CreateUserService
```

## ...
Criar arquivo
packages > server > src > modules > users > repositories > IUsersRepository.ts
e dentro colocar

```
import User from '../infra/typeorm/entities/User'
import ICreateUserDTO from '../dtos/ICreateUserDTO'

export default interface IUsersRepository {
  findById(id: string): Promise<User | undefined>
  findByEmail(email: string): Promise<User | undefined>
  create(data: ICreateUserDTO): Promise<User>
  save(user: User): Promise<User>
}
```

## ...
Criar pasta
packages > server > src > modules > users > infra > typeorm

## ...
Criar pasta
packages > server > src > modules > users > infra > typeorm > entities

## ...
Criar arquivo
packages > server > src > modules > users > infra > typeorm > entities > User.ts
e dentro colocar:

```
import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  CreateDateColumn,
  UpdateDateColumn,
} from 'typeorm'

import { Exclude, Expose } from 'class-transformer'

@Entity('users')
class User {
  @PrimaryGeneratedColumn('uuid')
  id: string

  @Column()
  name: string

  @Column()
  email: string

  @Column()
  @Exclude()
  password: string

  @Column()
  avatar: string

  @CreateDateColumn()
  created_at: Date

  @UpdateDateColumn()
  updated_at: Date

  @Expose({ name: 'avatar_url' })
  getAvatarUrl(): string | null {
    return this.avatar
      ? `${process.env.APP_API_URL}/files/${this.avatar}`
      : null
  }
}

export default User
```

## ...
dentro de
packages > server
rodar no terminal:

`yarn add typeorm pg mongodb`

## ...
Criar arquivo
packages > server > src > modules > users > dtos > ICreateUserDTO.ts
e dentro colocar:

```
export default interface ICreateUserDTO {
  name: string
  email: string
  password: string
}
```

## ...
Criar pasta
packages > server > src > @types

## ...
Criar arquivo
packages > server > src > @types > express.d.ts
e dentro colocar:

```
declare namespace Express {
  export interface Request {
    user: {
      id: string
    }
  }
}
```

## ...
Criar pasta
packages > server > src > modules > users > providers

## ...
Criar arquivo
packages > server > src > modules > users > providers > index.ts
e dentro colocar: 

```
import { container } from 'tsyringe'

import IHashProvider from './HashProvider/models/IHashProvider'
import BCryptHashProvider from './HashProvider/implementations/BCryptHashProvider'

container.registerSingleton<IHashProvider>('HashProvider', BCryptHashProvider)
```

## ...
Criar pasta
packages > server > src > modules > users > providers > HashProvider

## ...
Criar pasta
packages > server > src > modules > users > providers > HashProvider > models

## ...
Criar arquivo
packages > server > src > modules > users > providers > HashProvider > models > IHashProvider.ts
e dentro colocar: 

```
export default interface IHashProvider {
  generateHash(payload: string): Promise<string>
  compareHash(payload: string, hashed: string): Promise<boolean>
}
```

## ...
Criar pasta
packages > server > src > modules > users > providers > HashProvider > implementations

## ...
Criar arquivo
packages > server > src > modules > users > providers > HashProvider > implementations > BCryptHashProvider.ts
e dentro colocar: 

```
import { hash, compare } from 'bcryptjs'
import IHashProvider from '../models/IHashProvider'

export default class BCryptHashProvider implements IHashProvider {
  public async generateHash(payload: string): Promise<string> {
    return hash(payload, 8)
  }

  public async compareHash(payload: string, hashed: string): Promise<boolean> {
    return compare(payload, hashed)
  }
}
```

## ...
dentro de
packages > server
rodar no terminal:

`yarn add bcryptjs`

## ...
Criar arquivo
packages > server > src > modules > users > services > UpdateUserAvatarService.ts
e dentro colocar: 

```
import { injectable, inject } from 'tsyringe'

import AppError from '@shared/errors/AppError'

import IStorageProvider from '@shared/container/providers/StorageProvider/models/IStorageProvider'
import IUsersRepository from '../repositories/IUsersRepository'

import User from '../infra/typeorm/entities/User'

interface IRequest {
  user_id: string
  avatarFilename: string
}

@injectable()
class UpdateAvatarUserService {
  constructor(
    @inject('UsersRepository')
    private usersRepository: IUsersRepository,

    @inject('StorageProvider')
    private storageProvider: IStorageProvider,
  ) {}

  public async execute({ user_id, avatarFilename }: IRequest): Promise<User> {
    const user = await this.usersRepository.findById(user_id)

    if (!user) {
      throw new AppError(
        'Somente usuários autenticados podem trocar a foto',
        401,
      )
    }

    if (user.avatar) {
      await this.storageProvider.deleteFile(user.avatar)
    }

    const filename = await this.storageProvider.saveFile(avatarFilename)

    user.avatar = filename

    await this.usersRepository.save(user)

    return user
  }
}

export default UpdateAvatarUserService
```

## ...
Criar pasta
packages > server > src > shared > container

## ...
Criar arquivo
packages > server > src > shared > container > index.ts
e dentro colocar: 

```
import { container } from 'tsyringe'

import '@modules/users/providers'
import './providers'

import IUsersRepository from '@modules/users/repositories/IUsersRepository'
import UsersRepository from '@modules/users/infra/typeorm/repositories/UsersRepository'

import IUserTokensRepository from '@modules/users/repositories/IUserTokensRepository'
import UserTokensRepository from '@modules/users/infra/typeorm/repositories/UserTokensRepository'

import INotificationsRepository from '@modules/notifications/repositories/INotificationsRepository'
import NotificationsRepository from '@modules/notifications/infra/typeorm/repositories/NotificationsRepository'

container.registerSingleton<IUsersRepository>(
  'UsersRepository',
  UsersRepository,
)

container.registerSingleton<IUserTokensRepository>(
  'UserTokensRepository',
  UserTokensRepository,
)

container.registerSingleton<INotificationsRepository>(
  'NotificationsRepository',
  NotificationsRepository,
)
```

## ...
Criar pasta
packages > server > src > shared > container > providers

## ...
Criar arquivo
packages > server > src > shared > container > providers > index.ts
e dentro colocar: 

```
import './StorageProvider'
```

## ...
Criar pasta
packages > server > src > shared > container > providers > StorageProvider

## ...
Criar arquivo
packages > server > src > shared > container > providers > StorageProvider > index.ts
e dentro colocar: 

```
import { container } from 'tsyringe'

import IStorageProvider from './models/IStorageProvider'
import DiskStorageProvider from './implementations/DiskStorageProvider'

container.registerSingleton<IStorageProvider>(
  'StorageProvider',
  DiskStorageProvider
)
```

## ...
Criar pasta
packages > server > src > shared > container > providers > StorageProvider > models

## ...
Criar arquivo
packages > server > src > shared > container > providers > StorageProvider > models > IStorageProvider.ts
e dentro colocar: 

```
export default interface IStorageProvider {
  saveFile(file: string): Promise<string>
  deleteFile(file: string): Promise<void>
}
```

## ...
Criar pasta
packages > server > src > shared > container > providers > StorageProvider > implementations

## ...
Criar arquivo
packages > server > src > shared > container > providers > StorageProvider > implementations > DiskStorageProvider.ts
e dentro colocar: 

```
import fs from 'fs'
import path from 'path'
import uploadConfig from '@config/upload'
import IStorageProvider from '../models/IStorageProvider'

class DiskStorageProvider implements IStorageProvider {
  public async saveFile(file: string): Promise<string> {
    await fs.promises.rename(
      path.resolve(uploadConfig.tmpFolder, file),
      path.resolve(uploadConfig.uploadsFolder, file),
    )

    return file
  }

  public async deleteFile(file: string): Promise<void> {
    const filePath = path.resolve(uploadConfig.uploadsFolder, file)

    try {
      await fs.promises.stat(filePath)
    } catch {
      return
    }

    await fs.promises.unlink(filePath)
  }
}

export default DiskStorageProvider
```

## ...
Criar pasta
packages > server > src > modules > users > infra > typeorm > repositories

## ...
Criar arquivo
packages > server > src > modules > users > infra > typeorm > repositories > UsersRepository.ts
e dentro colocar: 

```
import { getRepository, Repository } from 'typeorm'

import IUsersRepository from '@modules/users/repositories/IUsersRepository'
import ICreateUserDTO from '@modules/users/dtos/ICreateUserDTO'

import User from '@modules/users/infra/typeorm/entities/User'

class UsersRepository implements IUsersRepository {
  private ormRepository: Repository<User>

  constructor() {
    this.ormRepository = getRepository(User)
  }

  public async findById(id: string): Promise<User | undefined> {
    const user = await this.ormRepository.findOne(id)

    return user
  }

  public async findByEmail(email: string): Promise<User | undefined> {
    const user = await this.ormRepository.findOne({ where: { email } })

    return user
  }

  public async create(userData: ICreateUserDTO): Promise<User> {
    const user = this.ormRepository.create(userData)

    await this.ormRepository.save(user)

    return user
  }

  public async save(user: User): Promise<User> {
    return this.ormRepository.save(user)
  }
}

export default UsersRepository
```

## ...
Criar arquivo
packages > server > src > modules > users > infra > typeorm > repositories > UserTokensRepository.ts
e dentro colocar: 

```
import { getRepository, Repository } from 'typeorm'

import IUserTokensRepository from '@modules/users/repositories/IUserTokensRepository'

import UserToken from '@modules/users/infra/typeorm/entities/UserToken'

class UserTokensRepository implements IUserTokensRepository {
  private ormRepository: Repository<UserToken>

  constructor() {
    this.ormRepository = getRepository(UserToken)
  }

  public async findByToken(token: string): Promise<UserToken | undefined> {
    const userToken = await this.ormRepository.findOne({
      where: { token },
    })

    return userToken
  }

  public async generate(user_id: string): Promise<UserToken> {
    const userToken = this.ormRepository.create({ user_id })

    await this.ormRepository.save(userToken)

    return userToken
  }
}

export default UserTokensRepository
```

## ...
Criar arquivo
packages > server > src > modules > users > infra > typeorm > entities > UserToken.ts
e dentro colocar: 

```
import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  CreateDateColumn,
  UpdateDateColumn,
  Generated,
} from 'typeorm'

@Entity('user_tokens')
class UserToken {
  @PrimaryGeneratedColumn('uuid')
  id: string

  @Column()
  @Generated('uuid')
  token: string

  @Column()
  user_id: string

  @CreateDateColumn()
  created_at: Date

  @UpdateDateColumn()
  updated_at: Date
}

export default UserToken
```

## ...
Criar arquivo
packages > server > src > modules > users > repositories > IUserTokensRepository.ts
e dentro colocar: 

```
import UserToken from '../infra/typeorm/entities/UserToken'

export default interface IUserTokensRepository {
  generate(user_id: string): Promise<UserToken>
  findByToken(token: string): Promise<UserToken | undefined>
}
```

## ...
Criar pasta
packages > server > src > modules > notifications

## ...
Criar pasta
packages > server > src > modules > notifications > repositories

## ...
Criar arquivo
packages > server > src > modules > notifications > repositories > INotificationsRepository.ts
e dentro colocar: 

```
import ICreateNotificationDTO from '../dtos/ICreateNotificationDTO'
import Notification from '../infra/typeorm/schemas/Notification'

export default interface INotificationsRepository {
  create(data: ICreateNotificationDTO): Promise<Notification>
}
```

## ...
Criar pasta
packages > server > src > modules > notifications > infra

## ...
Criar pasta
packages > server > src > modules > notifications > infra > typeorm

## ...
Criar pasta
packages > server > src > modules > notifications > infra > typeorm > repositories

## ...
Criar arquivo
packages > server > src > modules > notifications > infra > typeorm > repositories > NotificationsRepository.ts
e dentro colocar:

```
import { getMongoRepository, MongoRepository } from 'typeorm'

import INotificationsRepository from '@modules/notifications/repositories/INotificationsRepository'
import ICreateNotificationDTO from '@modules/notifications/dtos/ICreateNotificationDTO'

import Notification from '@modules/notifications/infra/typeorm/schemas/Notification'

class NotificationsRepository implements INotificationsRepository {
  private ormRepository: MongoRepository<Notification>

  constructor() {
    this.ormRepository = getMongoRepository(Notification, 'mongo')
  }

  public async create({
    content,
    recipient_id,
  }: ICreateNotificationDTO): Promise<Notification> {
    const notification = this.ormRepository.create({
      content,
      recipient_id,
    })

    await this.ormRepository.save(notification)

    return notification
  }
}

export default NotificationsRepository
```

## ...
Criar pasta
packages > server > src > modules > notifications > infra > typeorm > schemas

## ...
Criar arquivo
packages > server > src > modules > notifications > infra > typeorm > schemas > Notification.ts
e dentro colocar:

```
import {
  ObjectID,
  Entity,
  Column,
  CreateDateColumn,
  UpdateDateColumn,
  ObjectIdColumn,
} from 'typeorm'

@Entity('notifications')
class Notification {
  @ObjectIdColumn()
  id: ObjectID

  @Column()
  content: string

  @Column('uuid')
  recipient_id: string

  @Column({ default: false })
  read: boolean

  @CreateDateColumn()
  created_at: Date

  @UpdateDateColumn()
  updated_at: Date
}

export default Notification
```

## ...
Criar pasta
packages > server > src > modules > notifications > dtos

## ...
Criar arquivo
packages > server > src > modules > notifications > dtos > ICreateNotificationDTO.ts
e dentro colocar:

```
export default interface ICreateNotificationDTO {
  content: string
  recipient_id: string
}
```

## ...
Criar pasta
packages > server > src > shared > infra > http > routes

## ...
Criar arquivo
packages > server > src > shared > infra > http > routes > index.ts
e dentro colocar:

```
import { Router } from 'express'

import usersRouter from '@modules/users/infra/http/routes/users.routes'
import sessionsRouter from '@modules/users/infra/http/routes/sessions.routes'
import passwordRouter from '@modules/users/infra/http/routes/password.routes'
import profileRouter from '@modules/users/infra/http/routes/profile.routes'

const routes = Router()

routes.use('/users', usersRouter)
routes.use('/sessions', sessionsRouter)
routes.use('/password', passwordRouter)
routes.use('/profile', profileRouter)

export default routes
```

## ...
Substituir conteúdo de
packages > server > src > shared > infra > http > server.ts
por: 

```
import 'reflect-metadata'
import 'dotenv/config'

import express, { Request, Response, NextFunction } from 'express'
import cors from 'cors'
import { errors } from 'celebrate'
import 'express-async-errors'

import uploadConfig from '@config/upload'
import AppError from '@shared/errors/AppError'
import routes from './routes'

import '@shared/infra/typeorm'
import '@shared/container'

const app = express()

app.use(cors())
app.use(express.json())
app.use('/files', express.static(uploadConfig.uploadsFolder))
app.use(routes)

app.use(errors())

app.use((err: Error, request: Request, response: Response, _: NextFunction) => {
  if (err instanceof AppError) {
    return response.status(err.statusCode).json({
      status: 'error',
      message: err.message
    })
  }

  console.error(err)

  return response.status(500).json({
    status: 'error',
    message: 'Internal server error'
  })
})

app.listen(3333, () => {
  console.log('Server stated on port 3333')
})
```

## ...
Criar arquivo
packages > server > src > modules > users > infra > http > routes > sessions.routes.ts
e dentro colocar:

```
import { Router } from 'express'
import { celebrate, Segments, Joi } from 'celebrate'

import SessionsController from '../controllers/SessionsController'

const sessionsRouter = Router()
const sessionsController = new SessionsController()

sessionsRouter.post(
  '/',
  celebrate({
    [Segments.BODY]: {
      email: Joi.string().email().required(),
      password: Joi.string().required(),
    },
  }),
  sessionsController.create,
)

export default sessionsRouter
```

## ...
Criar arquivo
packages > server > src > modules > users > infra > http > controllers > SessionsController.ts
e dentro colocar:

```
import { Request, Response } from 'express'
import { container } from 'tsyringe'
import { classToClass } from 'class-transformer'

import AuthenticateUserService from '@modules/users/services/AuthenticateUserService'

export default class SessionsController {
  public async create(request: Request, response: Response): Promise<Response> {
    const { email, password } = request.body

    const authenticateUser = container.resolve(AuthenticateUserService)

    const { user, token } = await authenticateUser.execute({
      email,
      password,
    })

    return response.json({ user: classToClass(user), token })
  }
}
```

## ...
Criar arquivo
packages > server > src > modules > users > services > AuthenticateUserService.ts
e dentro colocar:

```
import { sign } from 'jsonwebtoken'
import authConfig from '@config/auth'
import { injectable, inject } from 'tsyringe'

import AppError from '@shared/errors/AppError'
import IHashProvider from '../providers/HashProvider/models/IHashProvider'
import IUsersRepository from '../repositories/IUsersRepository'

import User from '../infra/typeorm/entities/User'

interface IRequest {
  email: string
  password: string
}

interface IResponse {
  user: User
  token: string
}

@injectable()
class AuthenticateUserService {
  constructor(
    @inject('UsersRepository')
    private usersRepository: IUsersRepository,

    @inject('HashProvider')
    private hashProvider: IHashProvider,
  ) {}

  public async execute({ email, password }: IRequest): Promise<IResponse> {
    const user = await this.usersRepository.findByEmail(email)

    if (!user) {
      throw new AppError('E-mail ou senha inválidos', 401)
    }

    const passwordMatched = await this.hashProvider.compareHash(
      password,
      user.password,
    )

    if (!passwordMatched) {
      throw new AppError('E-mail ou senha inválidos', 401)
    }

    const { secret, expiresIn } = authConfig.jwt

    const token = sign({}, secret, {
      subject: user.id,
      expiresIn,
    })

    return { user, token }
  }
}

export default AuthenticateUserService
```

## ...
Criar arquivo
packages > server > src > modules > users > infra > http > routes > password.routes.ts
e dentro colocar:

```
import { Router } from 'express'
import { celebrate, Segments, Joi } from 'celebrate'

import ForgotPasswordController from '../controllers/ForgotPasswordController'
import ResetPasswordController from '../controllers/ResetPasswordController'

const passwordRouter = Router()
const forgotPasswordController = new ForgotPasswordController()
const resetPasswordController = new ResetPasswordController()

passwordRouter.post(
  '/forgot',
  celebrate({
    [Segments.BODY]: {
      email: Joi.string().email().required(),
    },
  }),
  forgotPasswordController.create,
)
passwordRouter.post(
  '/reset',
  celebrate({
    [Segments.BODY]: {
      token: Joi.string().uuid().required(),
      password: Joi.string().required(),
      password_confirmation: Joi.string().required().valid(Joi.ref('password')),
    },
  }),
  resetPasswordController.create,
)

export default passwordRouter
```

## ...
Criar arquivo
packages > server > src > modules > users > infra > http > controllers > ForgotPasswordController.ts
e dentro colocar:

```
import { Request, Response } from 'express'
import { container } from 'tsyringe'

import SendForgotPasswordEmailService from '@modules/users/services/SendForgotPasswordEmailService'

export default class ForgotPasswordController {
  public async create(request: Request, response: Response): Promise<Response> {
    const { email } = request.body

    const sendForgotPasswordEmail = container.resolve(
      SendForgotPasswordEmailService,
    )

    await sendForgotPasswordEmail.execute({
      email,
    })

    return response.status(204).json()
  }
}
```

## ...
Criar arquivo
packages > server > src > modules > users > infra > http > controllers > ResetPasswordController.ts
e dentro colocar:

```
import { Request, Response } from 'express'
import { container } from 'tsyringe'

import ResetPasswordService from '@modules/users/services/ResetPasswordService'

export default class ResetPasswordController {
  public async create(request: Request, response: Response): Promise<Response> {
    const { password, token } = request.body

    const resetPassword = container.resolve(ResetPasswordService)

    await resetPassword.execute({
      token,
      password,
    })

    return response.status(204).json()
  }
}
```

## ...
Criar arquivo
packages > server > src > modules > users > services > SendForgotPasswordEmailService.ts
e dentro colocar:

```
import { injectable, inject } from 'tsyringe'
import path from 'path'

import AppError from '@shared/errors/AppError'
import IMailProvider from '@shared/container/providers/MailProvider/models/IMailProvider'
import IUsersRepository from '../repositories/IUsersRepository'
import IUserTokensRepository from '../repositories/IUserTokensRepository'

interface IRequest {
  email: string
}

@injectable()
class SendForgotPasswordEmailService {
  constructor(
    @inject('UsersRepository')
    private usersRepository: IUsersRepository,

    @inject('MailProvider')
    private mailProvieder: IMailProvider,

    @inject('UserTokensRepository')
    private userTokensRepository: IUserTokensRepository,
  ) {}

  public async execute({ email }: IRequest): Promise<void> {
    const user = await this.usersRepository.findByEmail(email)

    if (!user) {
      throw new AppError('Usuário não existe')
    }

    const { token } = await this.userTokensRepository.generate(user.id)

    const forgotPasswordTemplate = path.resolve(
      __dirname,
      '..',
      'views',
      'forgot_password.hbs',
    )

    await this.mailProvieder.sendMail({
      to: {
        name: user.name,
        email: user.email,
      },
      subject: '[GoBarber] Recuperação de senha',
      templateData: {
        file: forgotPasswordTemplate,
        variables: {
          name: user.name,
          link: `${process.env.APP_WEB_URL}/reset-password?token=${token}`,
        },
      },
    })
  }
}

export default SendForgotPasswordEmailService
```

## ...
Criar arquivo
packages > server > src > modules > users > services > ResetPasswordService.ts
e dentro colocar:

```
import { injectable, inject } from 'tsyringe'
import { isAfter, addHours } from 'date-fns'

import AppError from '@shared/errors/AppError'
import IUsersRepository from '../repositories/IUsersRepository'
import IUserTokensRepository from '../repositories/IUserTokensRepository'
import IHashProvider from '../providers/HashProvider/models/IHashProvider'

interface IRequest {
  password: string
  token: string
}

@injectable()
class ResetPasswordService {
  constructor(
    @inject('UsersRepository')
    private usersRepository: IUsersRepository,

    @inject('UserTokensRepository')
    private userTokensRepository: IUserTokensRepository,

    @inject('HashProvider')
    private hashProvider: IHashProvider,
  ) {}

  public async execute({ token, password }: IRequest): Promise<void> {
    const userToken = await this.userTokensRepository.findByToken(token)

    if (!userToken) {
      throw new AppError('Token de usuário inexistente')
    }

    const user = await this.usersRepository.findById(userToken.user_id)

    if (!user) {
      throw new AppError('Usuário não existente')
    }

    const tokenCreatedAt = userToken.created_at
    const compareDate = addHours(tokenCreatedAt, 2)

    if (isAfter(Date.now(), compareDate)) {
      throw new AppError('Token expirado')
    }

    user.password = await this.hashProvider.generateHash(password)

    await this.usersRepository.save(user)
  }
}

export default ResetPasswordService
```

## ...
dentro de
packages > server
rodar no terminal:

`yarn add date-fns express-async-errors`

## ...
Criar pasta
packages > server > src > shared > container > providers > MailProvider

## ...
Criar arquivo
packages > server > src > shared > container > providers > MailProvider > index.ts
e dentro colocar:

```
import { container } from 'tsyringe'

import IMailProvider from './models/IMailProvider'
import EtherealMailProvider from './implementations/EtherealMailProvider'

container.registerInstance<IMailProvider>(
  'MailProvider',
  container.resolve(EtherealMailProvider)
)
```

## ...
Criar pasta
packages > server > src > shared > container > providers > MailProvider > models

## ...
Criar arquivo
packages > server > src > shared > container > providers > MailProvider > models > IMailProvider.ts
e dentro colocar:

```
import ISendMailDTO from '../dtos/ISendMailDTO'

export default interface IMailProvider {
  sendMail(data: ISendMailDTO): Promise<void>
}
```

## ...
Criar pasta
packages > server > src > shared > container > providers > MailProvider > implementations

## ...
Criar arquivo
packages > server > src > shared > container > providers > MailProvider > implementations > EtherealMailProvider.ts
e dentro colocar:

```
import nodemailer, { Transporter } from 'nodemailer'
import { inject, injectable } from 'tsyringe'

import IMailTemplateProvider from '@shared/container/providers/MailTemplateProvider/models/IMailTemplateProvider'
import IMailProvider from '../models/IMailProvider'
import ISendMailDTO from '../dtos/ISendMailDTO'

@injectable()
export default class EtherealMailProvider implements IMailProvider {
  private client: Transporter

  constructor(
    @inject('MailTemplateProvider')
    private mailTemplateProvider: IMailTemplateProvider
  ) {
    nodemailer.createTestAccount().then(account => {
      const transporter = nodemailer.createTransport({
        host: account.smtp.host,
        port: account.smtp.port,
        secure: account.smtp.secure,
        auth: {
          user: account.user,
          pass: account.pass
        }
      })

      this.client = transporter
    })
  }

  public async sendMail({
    to,
    from,
    subject,
    templateData
  }: ISendMailDTO): Promise<void> {
    const message = await this.client.sendMail({
      from: {
        name: from?.name || 'Equipe X',
        address: from?.email || 'equipe@x.com.br'
      },
      to: {
        name: to.name,
        address: to.email
      },
      subject,
      html: await this.mailTemplateProvider.parse(templateData)
    })

    console.log('Message sent: %s', message.messageId)
    console.log('Preview URL: %s', nodemailer.getTestMessageUrl(message))
  }
}
```


## ...
Criar pasta
packages > server > src > shared > container > providers > MailProvider > dtos

## ...
Criar arquivo
packages > server > src > shared > container > providers > MailProvider > dtos > ISendMailDTO.ts
e dentro colocar:

```
import IParseMailTemplateDTO from '@shared/container/providers/MailTemplateProvider/dtos/IParseMailTemplateDTO'

interface IMailContact {
  name: string
  email: string
}

export default interface ISendMailDTO {
  to: IMailContact
  from?: IMailContact
  subject: string
  templateData: IParseMailTemplateDTO
}
```

## ...
Criar pasta
packages > server > src > shared > container > providers > MailTemplateProvider

## ...
Criar arquivo
packages > server > src > shared > container > providers > MailTemplateProvider > index.ts
e dentro colocar:

```
import { container } from 'tsyringe'

import IMailTemplateProvider from './models/IMailTemplateProvider'
import HandlebarsMailTemplateProvider from './implementations/HandlebarsMailTemplateProvider'

container.registerSingleton<IMailTemplateProvider>(
  'MailTemplateProvider',
  HandlebarsMailTemplateProvider
)
```

## ...
Criar pasta
packages > server > src > shared > container > providers > MailTemplateProvider > models

## ...
Criar arquivo
packages > server > src > shared > container > providers > MailTemplateProvider > models > IMailTemplateProvider.ts
e dentro colocar:

```
import IParseMailTemplateDTO from '../dtos/IParseMailTemplateDTO'

export default interface IMailTemplateProvider {
  parse(data: IParseMailTemplateDTO): Promise<string>
}
```

## ...
Criar pasta
packages > server > src > shared > container > providers > MailTemplateProvider > implementations

## ...
Criar arquivo
packages > server > src > shared > container > providers > MailTemplateProvider > implementations > HandlebarsMailTemplateProvider.ts
e dentro colocar:

```
import handlebars from 'handlebars'
import fs from 'fs'

import IParseMailTemplateDTO from '../dtos/IParseMailTemplateDTO'
import IMailTemplateProvider from '../models/IMailTemplateProvider'

class HandlebarsMailTemplateProvider implements IMailTemplateProvider {
  public async parse({
    file,
    variables,
  }: IParseMailTemplateDTO): Promise<string> {
    const templateFileContent = await fs.promises.readFile(file, {
      encoding: 'utf-8',
    })

    const parseTemplate = handlebars.compile(templateFileContent)

    return parseTemplate(variables)
  }
}

export default HandlebarsMailTemplateProvider
```

## ...
Criar pasta
packages > server > src > shared > container > providers > MailTemplateProvider > dtos

## ...
Criar arquivo
packages > server > src > shared > container > providers > MailTemplateProvider > dtos > IParseMailTemplateDTO.ts
e dentro colocar:

```
interface ITemplateVariables {
  [key: string]: string | number
}

export default interface IParseMailTemplateDTO {
  file: string
  variables: ITemplateVariables
}
```

## ...
dentro de
packages > server
rodar no terminal:

`yarn add handlebars nodemailer`

## ...
Criar arquivo
packages > server > src > modules > users > infra > http > routes > profile.routes.ts
e dentro colocar:

```
import { Router } from 'express'
import { celebrate, Segments, Joi } from 'celebrate'

import ProfileController from '../controllers/ProfileController'

import ensureAuthenticated from '../middlewares/ensureAuthenticated'

const profileRouter = Router()
const profileController = new ProfileController()

profileRouter.use(ensureAuthenticated)

profileRouter.get('/', profileController.show)
profileRouter.put(
  '/',
  celebrate({
    [Segments.BODY]: {
      name: Joi.string().required(),
      email: Joi.string().email().required(),
      old_password: Joi.string(),
      password: Joi.string(),
      password_confirmation: Joi.string().valid(Joi.ref('password')),
    },
  }),
  profileController.update,
)

export default profileRouter
```

## ...
Criar arquivo
packages > server > src > modules > users > infra > http > controllers > ProfileController.ts
e dentro colocar:

```
import { Request, Response } from 'express'
import { container } from 'tsyringe'
import { classToClass } from 'class-transformer'

import UpdateProfileService from '@modules/users/services/UpdateProfileService'
import ShowProfileService from '@modules/users/services/ShowProfileService'

export default class ProfileController {
  public async show(request: Request, response: Response): Promise<Response> {
    const user_id = request.user.id

    const showProfile = container.resolve(ShowProfileService)

    const user = await showProfile.execute({ user_id })

    return response.json(classToClass(user))
  }

  public async update(request: Request, response: Response): Promise<Response> {
    const user_id = request.user.id
    const { name, email, old_password, password } = request.body

    const updateProfile = container.resolve(UpdateProfileService)

    const user = await updateProfile.execute({
      user_id,
      name,
      email,
      old_password,
      password,
    })

    delete user.password

    return response.json(classToClass(user))
  }
}
```

## ...
Criar arquivo
packages > server > src > modules > users > services > UpdateProfileService.ts
e dentro colocar:

```
import { injectable, inject } from 'tsyringe'

import AppError from '@shared/errors/AppError'

import IHashProvider from '../providers/HashProvider/models/IHashProvider'
import IUsersRepository from '../repositories/IUsersRepository'

import User from '../infra/typeorm/entities/User'

interface IRequest {
  user_id: string
  name: string
  email: string
  old_password?: string
  password?: string
}

@injectable()
class UpdateProfileService {
  constructor(
    @inject('UsersRepository')
    private usersRepository: IUsersRepository,

    @inject('HashProvider')
    private hashProvider: IHashProvider,
  ) {}

  public async execute({
    user_id,
    name,
    email,
    old_password,
    password,
  }: IRequest): Promise<User> {
    const user = await this.usersRepository.findById(user_id)

    if (!user) {
      throw new AppError('Usuário não encontrado')
    }

    const userWithUpdatedEmail = await this.usersRepository.findByEmail(email)

    if (userWithUpdatedEmail && userWithUpdatedEmail.id !== user_id) {
      throw new AppError('O e-mail passado já existe na base de dados')
    }

    user.name = name
    user.email = email

    if (password && !old_password) {
      throw new AppError(
        'Você precisa informar a senha antiga para alterar sua senha',
      )
    }

    if (password && old_password) {
      const checkOldPassword = await this.hashProvider.compareHash(
        old_password,
        user.password,
      )

      if (!checkOldPassword) {
        throw new AppError('Senha antiga incorreta')
      }

      user.password = await this.hashProvider.generateHash(password)
    }

    return this.usersRepository.save(user)
  }
}

export default UpdateProfileService
```

## ...
Criar arquivo
packages > server > src > modules > users > services > ShowProfileService.ts
e dentro colocar:

```
import { injectable, inject } from 'tsyringe'

import AppError from '@shared/errors/AppError'

import IUsersRepository from '../repositories/IUsersRepository'

import User from '../infra/typeorm/entities/User'

interface IRequest {
  user_id: string
}

@injectable()
class ShowProfileService {
  constructor(
    @inject('UsersRepository')
    private usersRepository: IUsersRepository,
  ) {}

  public async execute({ user_id }: IRequest): Promise<User> {
    const user = await this.usersRepository.findById(user_id)

    if (!user) {
      throw new AppError('Usuário não encontrado')
    }

    return user
  }
}

export default ShowProfileService
```

## ...
Alterar conteúdo de
packages > server > src > shared > container > providers > index.ts
por: 

```
import './StorageProvider'
import './MailProvider'
import './MailTemplateProvider'
```

## ...
Criar pasta
packages > server > src > shared > infra > typeorm

## ..
Criar arquivo
packages > server > src > shared > infra > typeorm > index.ts
e dentro colocar:

```
import { createConnections } from 'typeorm'

createConnections()
```

## ...
Criar pasta
packages > server > src > shared > infra > typeorm > migrations

## ...
Criar arquivo
packages > server > ormconfig.json
e dentro colocar:

```
[
  {
    "name": "default",
    "type": "postgres",
    "host": "localhost",
    "port": 5432,
    "username": "postgres",
    "password": "docker",
    "database": "dbname",
    "entities": ["./src/modules/**/infra/typeorm/entities/*.ts"],
    "migrations": ["./src/shared/infra/typeorm/migrations/*.ts"],
    "cli": {
      "migrationsDir": "./src/shared/infra/typeorm/migrations"
    }
  },
  {
    "name": "mongo",
    "type": "mongodb",
    "host": "localhost",
    "port": 27017,
    "database": "dbname",
    "useUnifiedTopology": true,
    "entities": ["./src/modules/**/infra/typeorm/schemas/*.ts"]
  }
]
```

## ...
Dentro de packages > server
rodar no terminal 
`yarn typeorm migration:create -n CreateUsers`

## ..
Dentro de
packages > server > src > shared > infra > typeorm > migrations
na migration criada alterar os métodos up e down por:

```
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
          name: 'avatar',
          type: 'varchar',
          isNullable: true
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

## ...
Dentro de packages > server
rodar no terminal 
`yarn typeorm migration:run`