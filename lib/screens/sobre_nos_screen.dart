import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/di/service_locator.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/section_title.dart';
import '../widgets/section_content.dart';
import '../viewmodels/navigation_viewmodel.dart';

/// Tela com informações sobre o CodeConnect
class SobreNosScreen extends StatefulWidget {
  const SobreNosScreen({super.key});

  @override
  State<SobreNosScreen> createState() => _SobreNosScreenState();
}

class _SobreNosScreenState extends State<SobreNosScreen> {
  late final NavigationViewModel _navigationViewModel = NavigationViewModel(
    ServiceLocator.instance.authCubit,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(UiConstants.paddingLarge),
          child: Column(
            spacing: UiConstants.spacingLarge,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'lib/assets/lampada.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(l10n.sobreNosWelcome, style: AppTheme.titleLarge),
                      Text(
                        l10n.sobreNosSubtitle,
                        style: AppTheme.titleLargeWhite,
                      ),
                    ],
                  ),
                ],
              ),
              SectionContent(l10n.sobreNosIntro),
              SectionTitle(l10n.sobreNosMissionTitle),
              SectionContent(l10n.sobreNosMissionText),
              Image.asset(
                'lib/assets/notebook.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              SectionTitle(l10n.sobreNosJoinTitle),
              SectionContent(l10n.sobreNosJoinText),
              Center(
                child: Image.asset(
                  'lib/assets/icon_logo_verde.png',
                  width: UiConstants.logoIconSize,
                  height: UiConstants.logoIconSize,
                ),
              ),
              Text(l10n.sobreNosFooter, style: AppTheme.bodyMedium),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        viewModel: _navigationViewModel,
        currentIndex: 3,
      ),
    );
  }
}
