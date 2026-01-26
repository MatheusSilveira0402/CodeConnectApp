import 'package:flutter/material.dart';
import 'core/constants.dart';
import 'screens/cadastro_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/perfil_screen.dart';
import 'screens/sobre_nos_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const CodeConnectApp());

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
