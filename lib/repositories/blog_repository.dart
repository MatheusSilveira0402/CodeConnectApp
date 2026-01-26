import 'package:dio/dio.dart';
import '../core/exceptions/api_exception.dart';
import '../core/http/http_client.dart';
import '../models/blog_post_model.dart';

/// Interface do repositório de blog posts
abstract class IBlogRepository {
  Future<List<BlogPostModel>> getPosts({int? limit, String? slug});
  Future<BlogPostModel> getPostById(String id);
  Future<BlogPostModel> getPostBySlug(String slug);
  Future<BlogPostModel> createPost(String title, String content);
  Future<BlogPostModel> updatePost(String id, String title, String content);
  Future<void> deletePost(String id);
  Future<BlogPostModel> likePost(String id);
  Future<List<CommentModel>> getComments(String postId);
  Future<CommentModel> createComment(String postId, String content);
}

/// Implementação do repositório de blog posts
class BlogRepository implements IBlogRepository {
  final Dio _dio = HttpClient.instance.dio;

  @override
  Future<List<BlogPostModel>> getPosts({int? limit, String? slug}) async {
    try {
      final response = await _dio.get(
        '/blog-posts',
        queryParameters: {
          if (limit != null) 'limit': limit,
          if (slug != null) 'slug': slug,
        },
      );
      return (response.data as List)
          .map((e) => BlogPostModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<BlogPostModel> getPostById(String id) async {
    try {
      final response = await _dio.get('/blog-posts/$id');
      return BlogPostModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<BlogPostModel> getPostBySlug(String slug) async {
    try {
      final response = await _dio.get('/blog-posts/slug/$slug');
      return BlogPostModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<BlogPostModel> createPost(String title, String content) async {
    try {
      final response = await _dio.post(
        '/blog-posts',
        data: {'title': title, 'content': content},
      );
      return BlogPostModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<BlogPostModel> updatePost(
    String id,
    String title,
    String content,
  ) async {
    try {
      final response = await _dio.patch(
        '/blog-posts/$id',
        data: {'title': title, 'content': content},
      );
      return BlogPostModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> deletePost(String id) async {
    try {
      await _dio.delete('/blog-posts/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<BlogPostModel> likePost(String id) async {
    try {
      final response = await _dio.post('/blog-posts/$id/like');
      return BlogPostModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<CommentModel>> getComments(String postId) async {
    try {
      final response = await _dio.get('/comments/post/$postId');
      return (response.data as List)
          .map((e) => CommentModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
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
      return CommentModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  ApiException _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return NetworkException('Timeout na conexão');
    }
    if (e.response?.statusCode == 401) {
      return UnauthorizedException();
    }
    return ApiException(
      message: e.response?.data['message'] ?? 'Erro desconhecido',
      statusCode: e.response?.statusCode,
      data: e.response?.data,
    );
  }
}
