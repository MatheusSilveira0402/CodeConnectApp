import 'package:hive_flutter/hive_flutter.dart';
import '../../models/blog_post_model.dart';
import 'hive_boxes.dart';

/// Cache local da lista de posts de um autor, usado quando não há conexão
class PostLocalDataSource {
  Box get _box => Hive.box(HiveBoxes.userPosts);

  Future<void> savePosts(String authorId, List<BlogPostModel> posts) async {
    await _box.put(authorId, posts.map((p) => p.toJson()).toList());
  }

  List<BlogPostModel> getPosts(String authorId) {
    final data = _box.get(authorId);
    if (data == null) return [];
    return (data as List)
        .map((e) => BlogPostModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }
}
