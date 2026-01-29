import 'package:json_annotation/json_annotation.dart';

part 'blog_post_model.g.dart';

/// Modelo de autor do post
@JsonSerializable()
class PostAuthor {
  final String id;
  final String name;
  final String? username;
  final String? avatar;

  PostAuthor({
    required this.id,
    required this.name,
    this.username,
    this.avatar,
  });

  factory PostAuthor.fromJson(Map<String, dynamic> json) =>
      _$PostAuthorFromJson(json);

  Map<String, dynamic> toJson() => _$PostAuthorToJson(this);
}

/// Modelo de post do blog
@JsonSerializable()
class BlogPostModel {
  final int id;
  final String? cover;
  final String? imageUrl;
  final String title;
  final String slug;
  final String body;
  final String markdown;
  final int likes;
  final PostAuthor author;
  final List<dynamic>? comments;
  final DateTime createdAt;
  final DateTime updatedAt;

  BlogPostModel({
    required this.id,
    this.cover,
    this.imageUrl,
    required this.title,
    required this.slug,
    required this.body,
    required this.markdown,
    this.likes = 0,
    required this.author,
    this.comments,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BlogPostModel.fromJson(Map<String, dynamic> json) =>
      _$BlogPostModelFromJson(json);

  Map<String, dynamic> toJson() => _$BlogPostModelToJson(this);

  // Getters para compatibilidade
  String get authorName => author.name;
  String get authorId => author.id;
  String get image => imageUrl ?? '';
}

/// Modelo de comentário
@JsonSerializable()
class CommentModel {
  final String id;
  final String postId;
  final String authorId;
  final String? authorName;
  final String content;
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.postId,
    required this.authorId,
    this.authorName,
    required this.content,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}
