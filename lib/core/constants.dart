/// Constantes de UI para dimensões, espaçamentos e tamanhos
class UiConstants {
  UiConstants._();

  // Tamanhos de ícones
  static const double iconSizeLarge = 100.0;
  static const double iconSizeSmall = 36.0;
  static const double logoIconSize = 100.0;

  // Espaçamentos
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 12.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;

  // Padding
  static const double paddingSmall = 12.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  // AppBar
  static const double appBarHeight = 130.0;

  // Border Radius
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 16.0;

  // Border Width
  static const double borderWidthDefault = 2.0;
}

/// Constantes de texto e mensagens do aplicativo
class AppStrings {
  AppStrings._();

  // App
  static const String appTitle = 'CodeConnect';

  // Navegação
  static const String navFeed = 'Feed';
  static const String navPerfil = 'Perfil';
  static const String navSobreNos = 'Sobre nós';
  static const String navSair = 'Sair';

  // Botões
  static const String btnPublicar = 'Publicar';
  static const String btnCancelar = 'Cancelar';

  // Telas
  static const String feedTitle = 'Feed de Publicações';
  static const String perfilTitle = 'Perfil do Usuário';
  static const String emBreve = 'Em breve...';

  // Diálogo Logout
  static const String logoutTitle = 'Sair';
  static const String logoutMessage = 'Deseja realmente sair?';

  // Sobre Nós
  static const String sobreNosWelcome = 'Bem-Vindo ao\nCodeConnect!';
  static const String sobreNosSubtitle =
      'Onde a comunidade\ne o código se unem!';
}

/// Constantes de rotas do aplicativo
class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String perfil = '/perfil';
  static const String sobre = '/sobre';
  static const String login = '/login';
  static const String cadastro = '/cadastro';
}
