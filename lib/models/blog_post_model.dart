import 'package:json_annotation/json_annotation.dart';

part 'blog_post_model.g.dart';

/// Modelo de post do blog
@JsonSerializable()
class BlogPostModel {
  final String id;
  final String title;
  final String content;
  final String slug;
  final String authorId;
  final String? authorName;
  final String? coverImage;
  final int likes;
  final int commentsCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  BlogPostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.slug,
    required this.authorId,
    this.authorName,
    this.coverImage,
    this.likes = 0,
    this.commentsCount = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BlogPostModel.fromJson(Map<String, dynamic> json) =>
      _$BlogPostModelFromJson(json);

  Map<String, dynamic> toJson() => _$BlogPostModelToJson(this);
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
