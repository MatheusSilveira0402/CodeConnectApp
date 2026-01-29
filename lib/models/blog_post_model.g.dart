// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostAuthor _$PostAuthorFromJson(Map<String, dynamic> json) => PostAuthor(
  id: json['id'] as String,
  name: json['name'] as String,
  username: json['username'] as String?,
  avatar: json['avatar'] as String?,
);

Map<String, dynamic> _$PostAuthorToJson(PostAuthor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'avatar': instance.avatar,
    };

BlogPostModel _$BlogPostModelFromJson(Map<String, dynamic> json) =>
    BlogPostModel(
      id: (json['id'] as num).toInt(),
      cover: json['cover'] as String?,
      imageUrl: json['imageUrl'] as String?,
      title: json['title'] as String,
      slug: json['slug'] as String,
      body: json['body'] as String,
      markdown: json['markdown'] as String,
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      author: PostAuthor.fromJson(json['author'] as Map<String, dynamic>),
      comments: json['comments'] as List<dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$BlogPostModelToJson(BlogPostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cover': instance.cover,
      'imageUrl': instance.imageUrl,
      'title': instance.title,
      'slug': instance.slug,
      'body': instance.body,
      'markdown': instance.markdown,
      'likes': instance.likes,
      'author': instance.author,
      'comments': instance.comments,
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
