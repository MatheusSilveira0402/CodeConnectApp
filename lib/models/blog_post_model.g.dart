// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogPostModel _$BlogPostModelFromJson(Map<String, dynamic> json) =>
    BlogPostModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      slug: json['slug'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String?,
      coverImage: json['coverImage'] as String?,
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      commentsCount: (json['commentsCount'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$BlogPostModelToJson(BlogPostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'slug': instance.slug,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'coverImage': instance.coverImage,
      'likes': instance.likes,
      'commentsCount': instance.commentsCount,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
  id: json['id'] as String,
  postId: json['postId'] as String,
  authorId: json['authorId'] as String,
  authorName: json['authorName'] as String?,
  content: json['content'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
    };
