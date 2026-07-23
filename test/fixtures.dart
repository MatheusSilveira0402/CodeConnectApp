import 'package:code_connect/models/blog_post_model.dart';
import 'package:code_connect/models/user_model.dart';

UserModel buildUser({String id = 'user-1', String name = 'Ana Paula'}) {
  return UserModel(
    id: id,
    name: name,
    email: 'ana@codeconnect.com',
    createdAt: DateTime(2024, 1, 1),
    updatedAt: DateTime(2024, 1, 1),
  );
}

BlogPostModel buildPost({int id = 1, String title = 'Meu projeto', int likes = 0}) {
  return BlogPostModel(
    id: id,
    title: title,
    slug: 'meu-projeto',
    body: 'Descrição do projeto',
    markdown: 'React',
    likes: likes,
    author: PostAuthor(id: 'user-1', name: 'Ana Paula'),
    createdAt: DateTime(2024, 1, 1),
    updatedAt: DateTime(2024, 1, 1),
  );
}
