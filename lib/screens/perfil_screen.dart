import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../core/constants.dart';
import '../repositories/user_repository.dart';
import '../stores/perfil_store.dart';
import '../widgets/code_connect_app_bar.dart';
import '../widgets/code_connect_nav_bar.dart';
import '../widgets/perfil/profile_actions_card.dart';
import '../widgets/perfil/user_profile_header.dart';
import '../viewmodels/navigation_viewmodel.dart';

/// Tela de perfil do usuário com integração à API
class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  late final PerfilStore _store;
  final _navigationViewModel = NavigationViewModel();

  @override
  void initState() {
    super.initState();
    _store = PerfilStore(UserRepository());
    _store.loadUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CodeConnectAppBar(),
      body: Observer(
        builder: (_) {
          if (_store.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_store.errorMessage != null && !_store.hasUser) {
            return Center(
              child: Column(
                spacing: UiConstants.spacingMedium,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  Text(
                    'Erro ao carregar perfil',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  if (_store.errorMessage != null)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: UiConstants.paddingLarge,
                      ),
                      child: Text(
                        _store.errorMessage!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ElevatedButton(
                    onPressed: () => _store.loadUserProfile(),
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          }

          if (!_store.hasUser) {
            return const Center(child: Text('Usuário não encontrado'));
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(UiConstants.paddingLarge),
            child: Column(
              spacing: UiConstants.spacingLarge,
              children: [
                UserProfileHeader(
                  user: _store.user!,
                  onAvatarTap: _handleAvatarTap,
                ),
                ProfileActionsCard(
                  onMyProjectsTap: _handleMyProjects,
                  onSharedTap: _handleSharedProjects,
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: CodeConnectNavBar(
        viewModel: _navigationViewModel,
        currentIndex: 1,
      ),
    );
  }

  void _handleAvatarTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Upload de avatar em breve...')),
    );
  }

  void _handleMyProjects() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Meus projetos em breve...')));
  }

  void _handleSharedProjects() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Projetos compartilhados em breve...')),
    );
  }
}
