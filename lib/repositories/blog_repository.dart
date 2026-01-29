import 'package:dio/dio.dart';
import '../core/exceptions/api_exception.dart';
import '../core/http/http_client.dart';
import '../core/utils/app_logger.dart';
import '../models/blog_post_model.dart';
import 'dart:io';

/// Interface do repositório de blog posts
abstract class IBlogRepository {
  Future<List<BlogPostModel>> getPosts({String? authorId, String? search});
  Future<BlogPostModel> getPostById(int id);
  Future<BlogPostModel> getPostBySlug(String slug);
  Future<BlogPostModel> createPost({
    required String title,
    required String body,
    required String markdown,
    required File image,
  });
  Future<BlogPostModel> updatePost({
    required int id,
    String? title,
    String? body,
    String? markdown,
  });
  Future<void> deletePost(int id);
  Future<BlogPostModel> likePost(int id);
  Future<List<CommentModel>> getComments(String postId);
  Future<CommentModel> createComment(String postId, String content);
}

/// Implementação do repositório de blog posts
class BlogRepository implements IBlogRepository {
  final Dio _dio = HttpClient.instance.dio;

  @override
  Future<List<BlogPostModel>> getPosts({
    String? authorId,
    String? search,
  }) async {
    try {
      final response = await _dio.get(
        '/blog-posts',
        queryParameters: {
          if (authorId != null) 'authorId': authorId,
          if (search != null) 'search': search,
        },
      );

      // Se não há dados ou é null, retorna lista vazia
      if (response.data == null) {
        return [];
      }

      // Se não é uma lista, retorna vazia
      if (response.data is! List) {
        return [];
      }

      // Se a lista está vazia, retorna vazia
      final List dataList = response.data as List;
      if (dataList.isEmpty) {
        return [];
      }

      // Parsear cada item da lista
      return dataList
          .map((e) => BlogPostModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      AppLogger.error('Erro ao buscar posts', e, null, 'BlogRepository');
      throw _handleError(e);
    } catch (e, stackTrace) {
      AppLogger.error(
        'Erro inesperado ao buscar posts',
        e,
        stackTrace,
        'BlogRepository',
      );
      return [];
    }
  }

  @override
  Future<BlogPostModel> getPostById(int id) async {
    try {
      final response = await _dio.get('/blog-posts/$id');
      AppLogger.debug('Post #$id carregado', 'BlogRepository');
      return BlogPostModel.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'Erro ao buscar post #$id',
        e,
        stackTrace,
        'BlogRepository',
      );
      throw _handleError(e);
    }
  }

  @override
  Future<BlogPostModel> getPostBySlug(String slug) async {
    try {
      final response = await _dio.get('/blog-posts/slug/$slug');
      AppLogger.debug('Post com slug "$slug" carregado', 'BlogRepository');
      return BlogPostModel.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'Erro ao buscar post por slug',
        e,
        stackTrace,
        'BlogRepository',
      );
      throw _handleError(e);
    }
  }

  @override
  Future<BlogPostModel> createPost({
    required String title,
    required String body,
    required String markdown,
    required File image,
  }) async {
    try {
      final formData = FormData.fromMap({
        'title': title,
        'body': body,
        'markdown': markdown,
        'image': await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      });

      final response = await _dio.post('/blog-posts', data: formData);
      AppLogger.info('Post criado: $title', 'BlogRepository');
      return BlogPostModel.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('Erro ao criar post', e, stackTrace, 'BlogRepository');
      throw _handleError(e);
    }
  }

  @override
  Future<BlogPostModel> updatePost({
    required int id,
    String? title,
    String? body,
    String? markdown,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (title != null) data['title'] = title;
      if (body != null) data['body'] = body;
      if (markdown != null) data['markdown'] = markdown;

      final response = await _dio.patch('/blog-posts/$id', data: data);
      AppLogger.info('Post #$id atualizado', 'BlogRepository');
      return BlogPostModel.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'Erro ao atualizar post #$id',
        e,
        stackTrace,
        'BlogRepository',
      );
      throw _handleError(e);
    }
  }

  @override
  Future<void> deletePost(int id) async {
    try {
      await _dio.delete('/blog-posts/$id');
      AppLogger.info('Post #$id excluído', 'BlogRepository');
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'Erro ao excluir post #$id',
        e,
        stackTrace,
        'BlogRepository',
      );
      throw _handleError(e);
    }
  }

  @override
  Future<BlogPostModel> likePost(int id) async {
    try {
      final response = await _dio.post('/blog-posts/$id/like');
      AppLogger.debug('Post #$id curtido', 'BlogRepository');
      return BlogPostModel.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'Erro ao curtir post #$id',
        e,
        stackTrace,
        'BlogRepository',
      );
      throw _handleError(e);
    }
  }

  @override
  Future<List<CommentModel>> getComments(String postId) async {
    try {
      final response = await _dio.get('/comments/post/$postId');
      final comments = (response.data as List)
          .map((e) => CommentModel.fromJson(e))
          .toList();
      AppLogger.debug(
        '${comments.length} comentários carregados',
        'BlogRepository',
      );
      return comments;
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'Erro ao buscar comentários',
        e,
        stackTrace,
        'BlogRepository',
      );
      throw _handleError(e);
    }
  }

  @override
  Future<CommentModel> createComment(String postId, String content) async {
    try {
      final response = await _dio.post(
        '/comments/post/$postId',
        data: {'content': content},
      );
      AppLogger.info('Comentário criado no post $postId', 'BlogRepository');
      return CommentModel.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'Erro ao criar comentário',
        e,
        stackTrace,
        'BlogRepository',
      );
      throw _handleError(e);
    }
  }

  ApiException _handleError(DioException e) {
    // Erros de rede/conexão
    if (e.type == DioExceptionType.connectionTimeout) {
      return NetworkException(
        'Tempo de conexão esgotado. Verifique sua internet.',
      );
    }
    if (e.type == DioExceptionType.receiveTimeout) {
      return NetworkException('Tempo de resposta esgotado. Tente novamente.');
    }
    if (e.type == DioExceptionType.connectionError) {
      return NetworkException('Erro de conexão. Verifique sua internet.');
    }

    // Erros HTTP
    final statusCode = e.response?.statusCode;
    final message = e.response?.data is Map
        ? (e.response?.data['message'] ?? e.response?.data['error'])
        : null;

    switch (statusCode) {
      case 400:
        return ApiException(
          message: message ?? 'Dados inválidos. Verifique as informações.',
          statusCode: 400,
          data: e.response?.data,
        );
      case 401:
        return UnauthorizedException(
          message ?? 'Sessão expirada. Faça login novamente.',
        );
      case 403:
        return ApiException(
          message: message ?? 'Você não tem permissão para realizar esta ação.',
          statusCode: 403,
          data: e.response?.data,
        );
      case 404:
        return ApiException(
          message: message ?? 'Post não encontrado.',
          statusCode: 404,
          data: e.response?.data,
        );
      case 413:
        return ApiException(
          message: 'Arquivo muito grande. Escolha uma imagem menor.',
          statusCode: 413,
          data: e.response?.data,
        );
      case 422:
        return ApiException(
          message: message ?? 'Dados inválidos.',
          statusCode: 422,
          data: e.response?.data,
        );
      case 500:
        return ApiException(
          message: 'Erro no servidor. Tente novamente mais tarde.',
          statusCode: 500,
          data: e.response?.data,
        );
      default:
        return ApiException(
          message:
              message ?? 'Erro ao processar a requisição. Tente novamente.',
          statusCode: statusCode,
          data: e.response?.data,
        );
    }
  }
}
