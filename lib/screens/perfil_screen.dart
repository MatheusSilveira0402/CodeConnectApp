import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/constants.dart';
import '../core/di/service_locator.dart';
import '../cubits/perfil/perfil_cubit.dart';
import '../cubits/perfil/perfil_state.dart';
import '../cubits/posts/posts_cubit.dart';
import '../cubits/posts/posts_state.dart';
import '../l10n/app_localizations.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/perfil/user_profile_header.dart';
import '../widgets/post_card.dart';
import '../viewmodels/navigation_viewmodel.dart';
import '../theme/app_theme.dart';
import 'criar_post_screen.dart';
import 'devs_near_you_screen.dart';

/// Tela de perfil do usuário com integração à API
class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  // Usando Service Locator para obter as instâncias gerenciadas
  late final PerfilCubit _perfilCubit = ServiceLocator.instance.perfilCubit;
  late final PostsCubit _postsCubit = ServiceLocator.instance
      .createUserPostsCubit();
  late final NavigationViewModel _navigationViewModel = NavigationViewModel(
    ServiceLocator.instance.authCubit,
  );

  String _activeTab = 'projetos'; // 'projetos' ou 'compartilhados'
  bool _postsLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    await _perfilCubit.loadUserProfile();
    final state = _perfilCubit.state;
    if (state is PerfilLoaded && !_postsLoaded) {
      _loadUserPosts(state.user.id);
      _postsLoaded = true;
    }
  }

  void _loadUserPosts(String authorId) async {
    await _postsCubit.fetchPosts(authorId: authorId);
  }

  Future<void> _navigateToCreatePost() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CriarPostScreen()),
    );

    if (!mounted) return;

    // Se retornou true, significa que um post foi criado/atualizado/deletado
    final state = _perfilCubit.state;
    if (result == true && state is PerfilLoaded) {
      _loadUserPosts(state.user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(onPublicarPressed: _navigateToCreatePost),
      body: BlocConsumer<PerfilCubit, PerfilState>(
        bloc: _perfilCubit,
        listenWhen: (previous, current) =>
            previous is PerfilLoaded &&
            previous.isOffline &&
            current is PerfilLoaded &&
            !current.isOffline,
        listener: (context, state) {
          // Conexão voltou: re-sincroniza a lista de posts com a API
          _loadUserPosts((state as PerfilLoaded).user.id);
        },
        builder: (context, state) {
          final l10n = AppLocalizations.of(context);
          if (state is PerfilLoading || state is PerfilInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PerfilError) {
            return Center(
              child: Column(
                spacing: UiConstants.spacingMedium,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  Text(
                    l10n.errorLoadingProfile,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: UiConstants.paddingLarge,
                    ),
                    child: Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _perfilCubit.loadUserProfile(),
                    child: Text(l10n.btnRetry),
                  ),
                ],
              ),
            );
          }

          if (state is! PerfilLoaded) {
            return const SizedBox.shrink();
          }
          final user = state.user;

          return SingleChildScrollView(
            padding: EdgeInsets.all(UiConstants.paddingLarge),
            child: Column(
              spacing: UiConstants.spacingLarge,
              children: [
                if (state.isOffline)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.orange.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.cloud_off,
                          size: 16,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          l10n.offlineBanner,
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                UserProfileHeader(user: user, onAvatarTap: _handleAvatarTap),
                OutlinedButton.icon(
                  onPressed: _handleShareLocation,
                  icon: const Icon(Icons.my_location, size: 18),
                  label: Text(
                    user.latitude != null
                        ? l10n.devsNearYouTitle
                        : l10n.shareLocationButton,
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primaryColor,
                    side: const BorderSide(color: AppTheme.primaryColor),
                  ),
                ),

                // Tabs
                Row(
                  children: [
                    Expanded(
                      child: _buildTab(
                        title: l10n.tabMyProjects,
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
                        title: l10n.tabApproved,
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
                  BlocBuilder<PostsCubit, PostsState>(
                    bloc: _postsCubit,
                    builder: (context, postsState) {
                      if (postsState.isLoading && postsState.posts.isEmpty) {
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

                      if (postsState.posts.isEmpty) {
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
                              Text(
                                l10n.noProjectsYet,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                l10n.shareYourProjects,
                                style: const TextStyle(
                                  color: AppTheme.textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return Column(
                        children: postsState.posts
                            .map(
                              (post) => PostCard(
                                post: post,
                                onLike: () => _postsCubit.likePost(post.id),
                                onEdit: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CriarPostScreen(post: post),
                                    ),
                                  );
                                  if (result == true) {
                                    _loadUserPosts(user.id);
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
                        Text(
                          l10n.noSharedProjects,
                          style: const TextStyle(
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
      SnackBar(content: Text(AppLocalizations.of(context).avatarUploadSoon)),
    );
  }

  Future<void> _handleShareLocation() async {
    final state = _perfilCubit.state;
    if (state is PerfilLoaded && state.user.latitude != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DevsNearYouScreen()),
      );
      return;
    }

    final l10n = AppLocalizations.of(context);
    final error = await _perfilCubit.shareLocation();
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error ?? l10n.locationSharedSuccess),
        backgroundColor: error == null ? Colors.green : Colors.red,
      ),
    );
  }
}
