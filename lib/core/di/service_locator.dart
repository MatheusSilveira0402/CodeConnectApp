import 'package:connectivity_plus/connectivity_plus.dart';
import '../../repositories/blog_repository.dart';
import '../../repositories/user_repository.dart';
import '../../cubits/auth/auth_cubit.dart';
import '../../cubits/perfil/perfil_cubit.dart';
import '../../cubits/posts/posts_cubit.dart';
import '../../cubits/post_form/post_form_cubit.dart';
import '../cache/user_local_data_source.dart';
import '../cache/post_local_data_source.dart';

/// Service Locator para gerenciamento de dependências
/// Implementa o padrão Singleton para garantir uma única instância
class ServiceLocator {
  ServiceLocator._();

  static final ServiceLocator _instance = ServiceLocator._();
  static ServiceLocator get instance => _instance;

  // Repositories (Singleton)
  IUserRepository? _userRepository;
  IBlogRepository? _blogRepository;

  // Data sources locais (cache offline, Singleton)
  UserLocalDataSource? _userLocalDataSource;
  PostLocalDataSource? _postLocalDataSource;

  // Cubits (Singleton)
  AuthCubit? _authCubit;
  PerfilCubit? _perfilCubit;

  bool _initialized = false;

  /// Inicializa todas as dependências do aplicativo.
  ///
  /// Os parâmetros opcionais existem para permitir injetar dublês
  /// (mocks/fakes) em testes de widget — em produção, `main()` chama
  /// `initialize()` sem argumentos e usa as implementações reais.
  void initialize({
    IUserRepository? userRepository,
    IBlogRepository? blogRepository,
    Stream<List<ConnectivityResult>>? connectivityStream,
  }) {
    if (_initialized) return;

    // Inicializar Repositories
    _userRepository = userRepository ?? UserRepository();
    _blogRepository = blogRepository ?? BlogRepository();

    // Inicializar data sources locais (cache offline)
    _userLocalDataSource = UserLocalDataSource();
    _postLocalDataSource = PostLocalDataSource();

    // Inicializar Cubits com suas dependências
    _authCubit = AuthCubit(_userRepository!);
    _perfilCubit = PerfilCubit(
      _userRepository!,
      _userLocalDataSource,
      null,
      connectivityStream,
    );

    _initialized = true;
  }

  /// Retorna a instância singleton do UserRepository
  IUserRepository get userRepository {
    _ensureInitialized();
    return _userRepository!;
  }

  /// Retorna a instância singleton do BlogRepository
  IBlogRepository get blogRepository {
    _ensureInitialized();
    return _blogRepository!;
  }

  /// Retorna a instância singleton do AuthCubit
  AuthCubit get authCubit {
    _ensureInitialized();
    return _authCubit!;
  }

  /// Retorna a instância singleton do PerfilCubit
  PerfilCubit get perfilCubit {
    _ensureInitialized();
    return _perfilCubit!;
  }

  /// Cria uma nova instância de PostsCubit sem cache local (não é singleton)
  /// Usado pelo feed da Home, que não precisa funcionar offline
  PostsCubit createPostsCubit() {
    _ensureInitialized();
    return PostsCubit(_blogRepository!);
  }

  /// Cria uma nova instância de PostsCubit com cache local (não é singleton)
  /// Usado pela aba "Meus projetos" do Perfil, que deve funcionar offline
  PostsCubit createUserPostsCubit() {
    _ensureInitialized();
    return PostsCubit(_blogRepository!, _postLocalDataSource);
  }

  /// Cria uma nova instância de PostFormCubit (não é singleton)
  /// Usado pela tela de criar/editar post
  PostFormCubit createPostFormCubit() {
    _ensureInitialized();
    return PostFormCubit(_blogRepository!);
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
