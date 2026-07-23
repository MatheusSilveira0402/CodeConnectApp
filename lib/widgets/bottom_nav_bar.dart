import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../viewmodels/navigation_viewmodel.dart';

/// Barra de navegação inferior do CodeConnect
class BottomNavBar extends StatelessWidget {
  final NavigationViewModel viewModel;
  final int currentIndex;

  const BottomNavBar({
    super.key,
    required this.viewModel,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: const Icon(Icons.feed), label: l10n.navFeed),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: l10n.navPerfil,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.map_outlined),
          label: l10n.navDevsNearYou,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.info),
          label: l10n.navSobreNos,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.logout),
          label: l10n.navSair,
        ),
      ],
      onTap: (index) => viewModel.navigateTo(context, index),
    );
  }
}
