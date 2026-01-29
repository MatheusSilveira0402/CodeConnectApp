import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/di/service_locator.dart';
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
    ServiceLocator.instance.authStore,
  );

  @override
  Widget build(BuildContext context) {
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
                      Text(
                        AppStrings.sobreNosWelcome,
                        style: AppTheme.titleLarge,
                      ),
                      Text(
                        AppStrings.sobreNosSubtitle,
                        style: AppTheme.titleLargeWhite,
                      ),
                    ],
                  ),
                ],
              ),
              const SectionContent(
                'No coração da revolução digital está o CodeConnect nasceu da visão de criar um espaço onde desenvolvedores e apaixonados e entusiastas da tecnologia podem se conectar, aprender e colaborar de maneira inigualável! Somos uma comunidade global apaixonada, por código e comprometidos em oferecer um ambiente inclusivo e acolhedor para todos os níveis de habilidade.',
              ),
              const SectionTitle('Nossa Missão'),
              const SectionContent(
                'Na CodeConnect, acreditamos que a colaboração é a essência da inovação. Nossa missão é fornecer uma plataforma onde as mentes criativas podem se unir, compartilhar conhecimento, e desenvolver projetos extraordinários. Quer você seja um novato ansioso para aprender ou um veterano experiente, você encontrará aqui um lar para suas aspirações tecnológicas.',
              ),
              Image.asset(
                'lib/assets/notebook.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              const SectionTitle('Junte-se a Nós!'),
              const SectionContent(
                'Estamos animados para ter você conosco nesta jornada empolgante. Junte-se à nossa comunidade vibrante e descubra o poder da colaboração no mundo do código',
              ),
              Center(
                child: Image.asset(
                  'lib/assets/icon_logo_verde.png',
                  width: UiConstants.logoIconSize,
                  height: UiConstants.logoIconSize,
                ),
              ),
              Text(
                'Juntos, vamos transformar ideias em inovações e moldar o futuro digital.',
                style: AppTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        viewModel: _navigationViewModel,
        currentIndex: 2,
      ),
    );
  }
}
