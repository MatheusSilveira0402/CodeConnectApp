import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../cubits/auth/auth_cubit.dart';
import '../l10n/app_localizations.dart';

/// ViewModel responsável por gerenciar a navegação do aplicativo
class NavigationViewModel extends ChangeNotifier {
  final AuthCubit _authCubit;
  int _currentIndex = 0;

  NavigationViewModel(this._authCubit);

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
        Navigator.pushReplacementNamed(context, AppRoutes.devsNearYou);
      case 3:
        Navigator.pushReplacementNamed(context, AppRoutes.sobre);
      case 4:
        _handleLogout(context);
    }
  }

  /// Exibe diálogo de confirmação de logout
  Future<void> _handleLogout(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final dialogL10n = AppLocalizations.of(dialogContext);
        return AlertDialog(
          title: Text(dialogL10n.logoutTitle),
          content: Text(dialogL10n.logoutMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(dialogL10n.btnCancelar),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text(dialogL10n.navSair),
            ),
          ],
        );
      },
    );

    if (confirm == true && context.mounted) {
      try {
        await _authCubit.logout();

        if (context.mounted) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.logoutError(e.toString())),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
