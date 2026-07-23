import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/cache/post_local_data_source.dart';
import '../../core/exceptions/api_exception.dart';
import '../../core/localization/app_localizations_context.dart';
import '../../core/utils/app_logger.dart';
import '../../repositories/blog_repository.dart';
import 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final IBlogRepository _repository;

  /// Cache local, opcional. Quando presente e a busca é por `authorId`
  /// (ex: "meus projetos" no Perfil), a listagem funciona offline-first.
  /// A Home (sem authorId) não usa cache.
  final PostLocalDataSource? _localDataSource;

  PostsCubit(this._repository, [this._localDataSource])
    : super(const PostsState());

  Future<void> fetchPosts({String? authorId, String? search}) async {
    emit(PostsState(isLoading: true, posts: state.posts));
    try {
      final posts = await _repository.getPosts(
        authorId: authorId,
        search: search,
      );
      AppLogger.info('Posts carregados: ${posts.length}', 'PostsCubit');
      if (_localDataSource != null && authorId != null) {
        await _localDataSource.savePosts(authorId, posts);
      }
      emit(PostsState(posts: posts));
    } on NetworkException catch (e, stackTrace) {
      AppLogger.error(
        'Sem conexão, tentando cache local',
        e,
        stackTrace,
        'PostsCubit',
      );
      if (_localDataSource != null && authorId != null) {
        final cachedPosts = _localDataSource.getPosts(authorId);
        if (cachedPosts.isNotEmpty) {
          AppLogger.info('Posts carregados do cache local', 'PostsCubit');
          emit(PostsState(posts: cachedPosts, isOffline: true));
          return;
        }
      }
      emit(
        PostsState(
          errorMessage: l10n.errorOfflineNoCache,
          posts: state.posts,
        ),
      );
    } on ApiException catch (e, stackTrace) {
      AppLogger.error('Erro ao buscar posts', e, stackTrace, 'PostsCubit');
      emit(PostsState(errorMessage: e.message, posts: state.posts));
    } catch (e, stackTrace) {
      final message = l10n.errorFetchPosts;
      AppLogger.error(message, e, stackTrace, 'PostsCubit');
      emit(PostsState(errorMessage: message, posts: state.posts));
    }
  }

  Future<void> likePost(int id) async {
    try {
      final updatedPost = await _repository.likePost(id);
      final posts = [...state.posts];
      final index = posts.indexWhere((p) => p.id == id);
      if (index != -1) {
        posts[index] = updatedPost;
      }
      AppLogger.debug('Post #$id curtido', 'PostsCubit');
      emit(PostsState(posts: posts));
    } on ApiException catch (e, stackTrace) {
      AppLogger.error('Erro ao curtir post #$id', e, stackTrace, 'PostsCubit');
      emit(PostsState(errorMessage: e.message, posts: state.posts));
    } catch (e, stackTrace) {
      final message = l10n.errorLikePost(id);
      AppLogger.error(message, e, stackTrace, 'PostsCubit');
      emit(PostsState(errorMessage: message, posts: state.posts));
    }
  }
}
