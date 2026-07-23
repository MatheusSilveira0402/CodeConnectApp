import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/cache/hive_boxes.dart';
import 'core/constants.dart';
import 'core/di/service_locator.dart';
import 'core/localization/app_localizations_context.dart';
import 'core/utils/app_logger.dart';
import 'l10n/app_localizations.dart';
import 'screens/cadastro_screen.dart';
import 'screens/devs_near_you_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/perfil_screen.dart';
import 'screens/sobre_nos_screen.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  // Garantir inicialização do Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Carregar variáveis de ambiente
  await dotenv.load(fileName: '.env');
  AppLogger.info('Variáveis de ambiente carregadas');

  // Inicializar cache local (Hive)
  await initHive();
  AppLogger.info('Cache local inicializado');

  // Inicializar dependências
  ServiceLocator.instance.initialize();
  AppLogger.info('Aplicativo iniciado com sucesso');

  runApp(const CodeConnectApp());
}

/// Aplicativo principal CodeConnect
class CodeConnectApp extends StatelessWidget {
  const CodeConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.cadastro: (context) => const CadastroScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.perfil: (context) => const PerfilScreen(),
        AppRoutes.devsNearYou: (context) => const DevsNearYouScreen(),
        AppRoutes.sobre: (context) => const SobreNosScreen(),
      },
    );
  }
}
