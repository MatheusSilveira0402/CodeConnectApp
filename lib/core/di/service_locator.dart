import '../../repositories/blog_repository.dart';
import '../../repositories/user_repository.dart';
import '../../stores/auth_store.dart';
import '../../stores/perfil_store.dart';
import '../../stores/post_store.dart';

/// Service Locator para gerenciamento de dependências
/// Implementa o padrão Singleton para garantir uma única instância
class ServiceLocator {
  ServiceLocator._();

  static final ServiceLocator _instance = ServiceLocator._();
  static ServiceLocator get instance => _instance;

  // Repositories (Singleton)
  late final IUserRepository _userRepository;
  late final IBlogRepository _blogRepository;

  // Stores (Singleton)
  late final AuthStore _authStore;
  late final PerfilStore _perfilStore;

  bool _initialized = false;

  /// Inicializa todas as dependências do aplicativo
  void initialize() {
    if (_initialized) return;

    // Inicializar Repositories
    _userRepository = UserRepository();
    _blogRepository = BlogRepository();

    // Inicializar Stores com suas dependências
    _authStore = AuthStore(_userRepository);
    _perfilStore = PerfilStore(_userRepository);

    _initialized = true;
  }

  /// Retorna a instância singleton do UserRepository
  IUserRepository get userRepository {
    _ensureInitialized();
    return _userRepository;
  }

  /// Retorna a instância singleton do BlogRepository
  IBlogRepository get blogRepository {
    _ensureInitialized();
    return _blogRepository;
  }

  /// Retorna a instância singleton do AuthStore
  AuthStore get authStore {
    _ensureInitialized();
    return _authStore;
  }

  /// Retorna a instância singleton do PerfilStore
  PerfilStore get perfilStore {
    _ensureInitialized();
    return _perfilStore;
  }

  /// Cria uma nova instância de PostStore (não é singleton)
  /// Cada tela que precisa de posts deve criar sua própria instância
  PostStore createPostStore() {
    _ensureInitialized();
    return PostStore(_blogRepository);
  }

  void _ensureInitialized() {
    if (!_initialized) {
      throw StateError(
        'ServiceLocator não foi inicializado. '
        'Chame ServiceLocator.instance.initialize() no main().',
      );
    }
  }

  /// Limpa todas as instâncias (útil para testes)
  void reset() {
    _initialized = false;
  }
}
