import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/sobre_nos_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const CodeConnectApp());

class CodeConnectApp extends StatelessWidget {
  const CodeConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodeConnect',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/sobre': (context) => const SobreNosScreen(),
      },
    );
  }
}
