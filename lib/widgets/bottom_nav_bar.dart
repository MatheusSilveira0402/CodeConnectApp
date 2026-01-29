import 'package:flutter/material.dart';
import '../core/constants.dart';
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
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.feed),
          label: AppStrings.navFeed,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: AppStrings.navPerfil,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: AppStrings.navSobreNos,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          label: AppStrings.navSair,
        ),
      ],
      onTap: (index) => viewModel.navigateTo(context, index),
    );
  }
}
