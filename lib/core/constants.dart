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

/// Constantes gerais do aplicativo.
///
/// Textos visíveis ao usuário (labels, botões, mensagens) ficam em
/// `lib/l10n/*.arb`, acessados via `AppLocalizations` — não aqui.
class AppStrings {
  AppStrings._();

  static const String appTitle = 'CodeConnect';
}

/// Constantes de rotas do aplicativo
class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String perfil = '/perfil';
  static const String devsNearYou = '/devs-near-you';
  static const String sobre = '/sobre';
  static const String login = '/login';
  static const String cadastro = '/cadastro';
}
