import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../core/constants.dart';
import '../core/di/service_locator.dart';
import '../stores/perfil_store.dart';
import '../stores/post_store.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/perfil/user_profile_header.dart';
import '../widgets/post_card.dart';
import '../viewmodels/navigation_viewmodel.dart';
import '../theme/app_theme.dart';
import 'criar_post_screen.dart';

/// Tela de perfil do usuário com integração à API
class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  // Usando Service Locator para obter as instâncias gerenciadas
  late final PerfilStore _store = ServiceLocator.instance.perfilStore;
  late final PostStore _postStore = ServiceLocator.instance.createPostStore();
  late final NavigationViewModel _navigationViewModel = NavigationViewModel(
    ServiceLocator.instance.authStore,
  );

  String _activeTab = 'projetos'; // 'projetos' ou 'compartilhados'
  bool _postsLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    await _store.loadUserProfile();
    if (_store.user != null && !_postsLoaded) {
      _loadUserPosts();
      _postsLoaded = true;
    }
  }

  void _loadUserPosts() async {
    // Carregar posts do usuário logado
    if (_store.user != null) {
      await _postStore.fetchPosts(authorId: _store.user!.id);
    }
  }

  Future<void> _navigateToCreatePost() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CriarPostScreen()),
    );

    if (!mounted) return;

    // Se retornou true, significa que um post foi criado/atualizado/deletado
    if (result == true) {
      _loadUserPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(onPublicarPressed: _navigateToCreatePost),
      body: Observer(
        builder: (_) {
          if (_store.isLoading && !_store.hasUser) {
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

                // Tabs
                Row(
                  children: [
                    Expanded(
                      child: _buildTab(
                        title: 'Meus projetos',
                        isActive: _activeTab == 'projetos',
                        onTap: () {
                          setState(() {
                            _activeTab = 'projetos';
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTab(
                        title: 'Aprovados',
                        isActive: _activeTab == 'compartilhados',
                        onTap: () {
                          setState(() {
                            _activeTab = 'compartilhados';
                          });
                        },
                      ),
                    ),
                  ],
                ),

                // Posts List
                if (_activeTab == 'projetos')
                  Observer(
                    builder: (_) {
                      if (_postStore.isLoading && _postStore.posts.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32),
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppTheme.primaryColor,
                              ),
                            ),
                          ),
                        );
                      }

                      if (_postStore.posts.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            children: [
                              Icon(
                                Icons.post_add,
                                size: 64,
                                color: AppTheme.primaryColor.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Você ainda não tem projetos',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Compartilhe seus projetos!',
                                style: TextStyle(
                                  color: AppTheme.textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return Column(
                        children: _postStore.posts
                            .map(
                              (post) => PostCard(
                                post: post,
                                onLike: () => _postStore.likePost(post.id),
                                onEdit: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CriarPostScreen(post: post),
                                    ),
                                  );
                                  if (result == true) {
                                    _loadUserPosts();
                                  }
                                },
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),

                if (_activeTab == 'compartilhados')
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Icon(
                          Icons.share,
                          size: 64,
                          color: AppTheme.primaryColor.withValues(alpha: 0.3),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Nenhum projeto compartilhado',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        viewModel: _navigationViewModel,
        currentIndex: 1,
      ),
    );
  }

  Widget _buildTab({
    required String title,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? AppTheme.primaryColor : AppTheme.borderColor,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isActive ? AppTheme.primaryColor : AppTheme.textSecondary,
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  void _handleAvatarTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Upload de avatar em breve...')),
    );
  }
}
