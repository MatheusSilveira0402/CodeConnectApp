import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/exceptions/api_exception.dart';
import '../../core/localization/app_localizations_context.dart';
import '../../core/utils/app_logger.dart';
import '../../models/blog_post_model.dart';
import '../../repositories/blog_repository.dart';
import 'post_form_state.dart';

class PostFormCubit extends Cubit<PostFormState> {
  final IBlogRepository _repository;

  PostFormCubit(this._repository) : super(const PostFormInitial());

  Future<BlogPostModel?> createPost({
    required String title,
    required String body,
    required String markdown,
    required File image,
  }) async {
    emit(const PostFormLoading());
    try {
      final post = await _repository.createPost(
        title: title,
        body: body,
        markdown: markdown,
        image: image,
      );
      AppLogger.info(
        'Post criado com sucesso: ${post.title}',
        'PostFormCubit',
      );
      emit(PostFormSuccess(post));
      return post;
    } on ApiException catch (e, stackTrace) {
      AppLogger.error('Erro ao criar post', e, stackTrace, 'PostFormCubit');
      emit(PostFormError(e.message));
      return null;
    } catch (e, stackTrace) {
      final message = l10n.errorCreatePost;
      AppLogger.error(message, e, stackTrace, 'PostFormCubit');
      emit(PostFormError(message));
      return null;
    }
  }

  Future<BlogPostModel?> updatePost({
    required int id,
    String? title,
    String? body,
    String? markdown,
  }) async {
    emit(const PostFormLoading());
    try {
      final post = await _repository.updatePost(
        id: id,
        title: title,
        body: body,
        markdown: markdown,
      );
      AppLogger.info('Post #$id atualizado', 'PostFormCubit');
      emit(PostFormSuccess(post));
      return post;
    } on ApiException catch (e, stackTrace) {
      AppLogger.error(
        'Erro ao atualizar post #$id',
        e,
        stackTrace,
        'PostFormCubit',
      );
      emit(PostFormError(e.message));
      return null;
    } catch (e, stackTrace) {
      final message = l10n.errorUpdatePost(id);
      AppLogger.error(message, e, stackTrace, 'PostFormCubit');
      emit(PostFormError(message));
      return null;
    }
  }

  Future<bool> deletePost(int id) async {
    emit(const PostFormLoading());
    try {
      await _repository.deletePost(id);
      AppLogger.info('Post #$id excluído', 'PostFormCubit');
      emit(const PostFormSuccess(null));
      return true;
    } on ApiException catch (e, stackTrace) {
      AppLogger.error(
        'Erro ao excluir post #$id',
        e,
        stackTrace,
        'PostFormCubit',
      );
      emit(PostFormError(e.message));
      return false;
    } catch (e, stackTrace) {
      final message = l10n.errorDeletePost(id);
      AppLogger.error(message, e, stackTrace, 'PostFormCubit');
      emit(PostFormError(message));
      return false;
    }
  }
}
