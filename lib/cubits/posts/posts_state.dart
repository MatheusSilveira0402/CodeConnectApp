import 'package:equatable/equatable.dart';
import '../../models/blog_post_model.dart';

/// Estado da listagem de posts (feed e "meus projetos").
///
/// Não é um sealed state porque a UI precisa manter a lista visível
/// durante um refresh (loading = true com posts já preenchidos).
class PostsState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final List<BlogPostModel> posts;

  /// true quando a lista veio do cache local por falta de conexão
  final bool isOffline;

  const PostsState({
    this.isLoading = false,
    this.errorMessage,
    this.posts = const [],
    this.isOffline = false,
  });

  @override
  List<Object?> get props => [isLoading, errorMessage, posts, isOffline];
}
