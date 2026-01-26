import 'package:flutter/material.dart';
import '../core/constants.dart';

/// ViewModel responsável por gerenciar a navegação do aplicativo
class NavigationViewModel extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  /// Atualiza o índice atual da navegação
  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  /// Navega para a tela correspondente ao índice selecionado
  void navigateTo(BuildContext context, int index) {
    setIndex(index);

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      case 1:
        Navigator.pushReplacementNamed(context, AppRoutes.perfil);
      case 2:
        Navigator.pushReplacementNamed(context, AppRoutes.sobre);
      case 3:
        _handleLogout(context);
    }
  }

  /// Exibe diálogo de confirmação de logout
  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.logoutTitle),
        content: const Text(AppStrings.logoutMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.btnCancelar),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            },
            child: const Text(AppStrings.navSair),
          ),
        ],
      ),
    );
  }
}
