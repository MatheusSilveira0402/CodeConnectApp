import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/code_connect_app_bar.dart';
import '../widgets/code_connect_logo.dart';
import '../widgets/section_widgets.dart';

class SobreNosScreen extends StatelessWidget {
  const SobreNosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CodeConnectAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            spacing: 16,
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
                        'Bem-Vindo ao\nCodeConnect!',
                        style: AppTheme.titleLarge,
                      ),
                      Text(
                        'Onde a comunidade\ne o código se unem!',
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
              const FeatureImage(
                imagePath: 'lib/assets/notebook.png',
                height: 240,
              ),
              const SectionTitle('Junte-se a Nós!'),
              const SectionContent(
                'Estamos animados para ter você conosco nesta jornada empolgante. Junte-se à nossa comunidade vibrante e descubra o poder da colaboração no mundo do código',
              ),
              const Center(child: CodeConnectLogo(height: 48)),
              const Center(
                child: Text(
                  'Juntos, vamos transformar\nideias em inovações e moldar\no futuro digital.',
                  textAlign: TextAlign.center,
                  style: AppTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Sobre nós'),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Sair'),
        ],
        onTap: (index) {
          if (index == 0) Navigator.pushReplacementNamed(context, '/');
        },
      ),
    );
  }
}
