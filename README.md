# CodeConnect 

Aplicativo Flutter de blog com autenticação, gerenciamento de perfil e criação de posts. O projeto foi desenvolvido com foco em arquitetura limpa e boas práticas de desenvolvimento.

## Sobre o Projeto

Este é um aplicativo completo de blog que implementa:

- Arquitetura MVVM (Model-View-ViewModel)
- Princípios SOLID para código manutenível
- Clean Code e padrões de projeto
- MobX para gerenciamento de estado reativo
- Dependency Injection com Service Locator
- Sistema de logging para debugging
- Tratamento de erros consistente
- Armazenamento seguro de tokens com FlutterSecureStorage

## Tecnologias Utilizadas

- Flutter - Framework multiplataforma
- Dart - Linguagem de programação
- MobX - Gerenciamento de estado
- Dio - Cliente HTTP
- FlutterSecureStorage - Armazenamento seguro
- JsonSerializable - Serialização JSON
- BuildRunner - Geração de código

## Estrutura do Projeto

```
lib/
├── core/                        # Núcleo da aplicação
│   ├── constants.dart          # Constantes (UI, Strings, Routes)
│   ├── di/                     # Dependency Injection
│   ├── exceptions/             # Exceções customizadas
│   ├── http/                   # Cliente HTTP configurado
│   ├── secure/                 # Armazenamento seguro
│   ├── utils/                  # Utilitários (Logger, ApiHelper)
│   └── validators/             # Validadores de formulário
├── models/                      # Modelos de dados
│   ├── user_model.dart
│   ├── blog_post_model.dart
│   └── auth_response_model.dart
├── repositories/                # Camada de dados (API)
│   ├── user_repository.dart
│   └── blog_repository.dart
├── stores/                      # Estado (MobX Stores)
│   ├── auth_store.dart
│   ├── perfil_store.dart
│   └── post_store.dart
├── viewmodels/                  # Lógica de apresentação
│   └── navigation_viewmodel.dart
├── screens/                     # Telas da aplicação
│   ├── login_screen.dart
│   ├── cadastro_screen.dart
│   ├── home_screen.dart
│   ├── perfil_screen.dart
│   ├── criar_post_screen.dart
│   └── sobre_nos_screen.dart
├── widgets/                     # Componentes reutilizáveis
│   ├── auth/                   # Componentes de autenticação
│   ├── perfil/                 # Componentes de perfil
│   └── [outros widgets]
└── theme/                       # Tematização
    └── app_theme.dart
```

## Como Executar

### Pré-requisitos

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Git

### Instalação

1. Clone o repositório:
```bash
git clone https://github.com/seu-usuario/code_connect.git
cd code_connect
```

2. Configure as variáveis de ambiente:
```bash
cp .env.example .env
```
Edite o arquivo `.env` com a URL da sua API.

3. Instale as dependências:
```bash
flutter pub get
```

4. Gere os arquivos do build_runner:
```bash
dart run build_runner build --delete-conflicting-outputs
```

5. Execute o aplicativo:
```bash
flutter run
```

## Comandos Úteis

### Build Runner (Geração de Código)

```bash
# Gerar arquivos uma vez
dart run build_runner build --delete-conflicting-outputs

# Modo watch (regenera automaticamente ao salvar)
dart run build_runner watch --delete-conflicting-outputs

# Limpar arquivos gerados
dart run build_runner clean
```

### Análise de Código

```bash
# Verificar problemas no código
dart analyze

# Formatar código
dart format .

# Rodar testes
flutter test
```

## Configuração de Ambiente

Crie um arquivo `.env` na raiz do projeto baseado no `.env.example`:

```env
API_BASE_URL=http://seu-servidor:3000
```

**Configurações recomendadas:**
- **Desenvolvimento local:** `http://192.168.1.XXX:3000`
- **Emulador Android:** `http://10.0.2.2:3000`
- **iOS Simulator:** `http://localhost:3000`
- **Produção:** `https://api.seudominio.com`

> **Importante:** Nunca commite o arquivo `.env` com credenciais reais! Use apenas o `.env.example` como template.

## Arquivos Gerados

Este projeto usa **build_runner** para gerar código automaticamente:

- `*.g.dart` - Arquivos gerados pelo MobX e JsonSerializable
- `*.gr.dart` - Arquivos de rotas (se usar AutoRoute)
- `*.freezed.dart` - Classes imutáveis (se usar Freezed)

**Estes arquivos não devem ser commitados** - eles são gerados automaticamente quando você roda:
```bash
dart run build_runner build
```

## Arquitetura

O projeto segue o padrão **MVVM** (Model-View-ViewModel):

### Model
Representação dos dados da aplicação (User, BlogPost, etc.)

### View  
Camada de UI - Screens e Widgets que exibem os dados

### ViewModel
Lógica de apresentação - Stores MobX que gerenciam estado e comunicam com repositórios

### Repository
Camada de acesso a dados - Comunicação com API REST

### Dependency Injection
Service Locator pattern para gerenciar dependências

## Segurança

- Tokens: Armazenados com FlutterSecureStorage (criptografia nativa)
- Senhas: Nunca armazenadas localmente, apenas enviadas à API
- HTTPS: Recomendado para produção
- Environment Variables: Configurações sensíveis isoladas no arquivo .env

## Qualidade de Código

O projeto mantém zero erros e zero warnings no análise estático:

```bash
$ dart analyze
Analyzing code_connect...
No issues found!
```

## Contribuindo

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/MinhaFeature`)
3. Commit suas mudanças (`git commit -m 'Add: Minha nova feature'`)
4. Push para a branch (`git push origin feature/MinhaFeature`)
5. Abra um Pull Request

## Licença

Este projeto está sob a licença MIT.

---

Desenvolvido seguindo as melhores práticas de Flutter e Clean Code.
