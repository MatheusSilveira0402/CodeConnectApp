import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/code_connect_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CodeConnectAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.code,
              size: 100,
              color: AppTheme.primaryColor.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 24),
            const Text(
              'Feed de Publicações',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Em breve...',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 16),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Sobre nós'),
        ],
        onTap: (index) =>
            index == 2 ? Navigator.pushNamed(context, '/sobre') : null,
      ),
    );
  }
}
