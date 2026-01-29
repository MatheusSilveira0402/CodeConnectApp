import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../stores/auth_store.dart';

/// ViewModel responsável por gerenciar a navegação do aplicativo
class NavigationViewModel extends ChangeNotifier {
  final AuthStore _authStore;
  int _currentIndex = 0;

  NavigationViewModel(this._authStore);

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
  Future<void> _handleLogout(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.logoutTitle),
        content: const Text(AppStrings.logoutMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(AppStrings.btnCancelar),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text(AppStrings.navSair),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      try {
        await _authStore.logout();

        if (context.mounted) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao fazer logout: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
