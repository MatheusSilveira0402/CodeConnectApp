import 'package:mobx/mobx.dart';
import 'dart:io';
import '../core/utils/app_logger.dart';
import '../models/blog_post_model.dart';
import '../repositories/blog_repository.dart';

part 'post_store.g.dart';

/// Store para gerenciamento de estado de posts do blog
/// Implementa padrão Observer (MobX) para reatividade
// ignore: library_private_types_in_public_api
class PostStore = _PostStoreBase with _$PostStore;

abstract class _PostStoreBase with Store {
  final IBlogRepository _repository;

  _PostStoreBase(this._repository);

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  List<BlogPostModel> posts = [];

  @observable
  BlogPostModel? currentPost;

  @action
  Future<void> fetchPosts({String? authorId, String? search}) async {
    isLoading = true;
    errorMessage = null;
    try {
      posts = await _repository.getPosts(authorId: authorId, search: search);
      AppLogger.info('Posts carregados: ${posts.length}', 'PostStore');
    } catch (e, stackTrace) {
      final message = 'Erro ao buscar posts';
      errorMessage = message;
      AppLogger.error(message, e, stackTrace, 'PostStore');
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> fetchPostById(int id) async {
    isLoading = true;
    errorMessage = null;
    try {
      currentPost = await _repository.getPostById(id);
      AppLogger.info('Post $id carregado', 'PostStore');
    } catch (e, stackTrace) {
      final message = 'Erro ao buscar post #$id';
      errorMessage = message;
      AppLogger.error(message, e, stackTrace, 'PostStore');
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<BlogPostModel?> createPost({
    required String title,
    required String body,
    required String markdown,
    required File image,
  }) async {
    isLoading = true;
    errorMessage = null;
    try {
      final post = await _repository.createPost(
        title: title,
        body: body,
        markdown: markdown,
        image: image,
      );
      posts.insert(0, post);
      AppLogger.info('Post criado com sucesso: ${post.title}', 'PostStore');
      return post;
    } catch (e, stackTrace) {
      final message = 'Erro ao criar post';
      errorMessage = message;
      AppLogger.error(message, e, stackTrace, 'PostStore');
      return null;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<BlogPostModel?> updatePost({
    required int id,
    String? title,
    String? body,
    String? markdown,
  }) async {
    isLoading = true;
    errorMessage = null;
    try {
      final updatedPost = await _repository.updatePost(
        id: id,
        title: title,
        body: body,
        markdown: markdown,
      );

      final index = posts.indexWhere((p) => p.id == id);
      if (index != -1) {
        posts[index] = updatedPost;
      }

      currentPost = updatedPost;
      AppLogger.info('Post #$id atualizado', 'PostStore');
      return updatedPost;
    } catch (e, stackTrace) {
      final message = 'Erro ao atualizar post #$id';
      errorMessage = message;
      AppLogger.error(message, e, stackTrace, 'PostStore');
      return null;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> deletePost(int id) async {
    isLoading = true;
    errorMessage = null;
    try {
      await _repository.deletePost(id);
      posts.removeWhere((p) => p.id == id);
      if (currentPost?.id == id) {
        currentPost = null;
      }
      AppLogger.info('Post #$id excluído', 'PostStore');
      return true;
    } catch (e, stackTrace) {
      final message = 'Erro ao excluir post #$id';
      errorMessage = message;
      AppLogger.error(message, e, stackTrace, 'PostStore');
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> likePost(int id) async {
    try {
      final updatedPost = await _repository.likePost(id);
      final index = posts.indexWhere((p) => p.id == id);
      if (index != -1) {
        posts[index] = updatedPost;
      }
      if (currentPost?.id == id) {
        currentPost = updatedPost;
      }
      AppLogger.debug('Post #$id curtido', 'PostStore');
    } catch (e, stackTrace) {
      final message = 'Erro ao curtir post #$id';
      errorMessage = message;
      AppLogger.error(message, e, stackTrace, 'PostStore');
    }
  }

  @action
  void clearError() {
    errorMessage = null;
  }
}
