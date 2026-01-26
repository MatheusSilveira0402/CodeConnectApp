import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../theme/app_theme.dart';
import '../widgets/code_connect_app_bar.dart';
import '../widgets/code_connect_nav_bar.dart';
import '../viewmodels/navigation_viewmodel.dart';

/// Tela inicial com feed de publicações
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = NavigationViewModel();

    return Scaffold(
      appBar: const CodeConnectAppBar(),
      body: Center(
        child: Column(
          spacing: UiConstants.spacingLarge,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.code,
              size: UiConstants.iconSizeLarge,
              color: AppTheme.primaryColor.withValues(alpha: 0.3),
            ),
            const Text(
              AppStrings.feedTitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              AppStrings.emBreve,
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 16),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CodeConnectNavBar(
        viewModel: viewModel,
        currentIndex: 0,
      ),
    );
  }
}
