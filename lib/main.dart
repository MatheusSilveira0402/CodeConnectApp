import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/constants.dart';
import 'core/di/service_locator.dart';
import 'core/utils/app_logger.dart';
import 'screens/cadastro_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/perfil_screen.dart';
import 'screens/sobre_nos_screen.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  // Garantir inicialização do Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Carregar variáveis de ambiente
  await dotenv.load(fileName: '.env');
  AppLogger.info('Variáveis de ambiente carregadas');

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
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.cadastro: (context) => const CadastroScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.perfil: (context) => const PerfilScreen(),
        AppRoutes.sobre: (context) => const SobreNosScreen(),
      },
    );
  }
}
