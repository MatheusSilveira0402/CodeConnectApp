import 'package:bloc_test/bloc_test.dart';
import 'package:code_connect/core/exceptions/api_exception.dart';
import 'package:code_connect/cubits/posts/posts_cubit.dart';
import 'package:code_connect/cubits/posts/posts_state.dart';
import 'package:code_connect/repositories/blog_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../fixtures.dart';

class MockBlogRepository extends Mock implements IBlogRepository {}

void main() {
  late MockBlogRepository repository;

  setUp(() {
    repository = MockBlogRepository();
  });

  group('PostsCubit.fetchPosts', () {
    blocTest<PostsCubit, PostsState>(
      'emite loading e depois a lista de posts quando dá certo',
      setUp: () {
        when(
          () => repository.getPosts(authorId: null, search: null),
        ).thenAnswer((_) async => [buildPost()]);
      },
      build: () => PostsCubit(repository),
      act: (cubit) => cubit.fetchPosts(),
      expect: () => [
        const PostsState(isLoading: true),
        isA<PostsState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.posts.length, 'posts.length', 1),
      ],
    );

    blocTest<PostsCubit, PostsState>(
      'emite estado de erro sem apagar os posts já carregados',
      setUp: () {
        when(
          () => repository.getPosts(authorId: null, search: null),
        ).thenThrow(ApiException(message: 'Erro no servidor.', statusCode: 500));
      },
      build: () => PostsCubit(repository),
      act: (cubit) => cubit.fetchPosts(),
      expect: () => [
        const PostsState(isLoading: true),
        isA<PostsState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.errorMessage, 'errorMessage', isNotNull)
            .having((s) => s.posts, 'posts', isEmpty),
      ],
    );
  });

  group('PostsCubit.likePost', () {
    blocTest<PostsCubit, PostsState>(
      'atualiza o post curtido na lista',
      seed: () => PostsState(posts: [buildPost(likes: 0)]),
      setUp: () {
        when(
          () => repository.likePost(1),
        ).thenAnswer((_) async => buildPost(likes: 1));
      },
      build: () => PostsCubit(repository),
      act: (cubit) => cubit.likePost(1),
      expect: () => [
        isA<PostsState>().having(
          (s) => s.posts.first.likes,
          'posts.first.likes',
          1,
        ),
      ],
    );
  });
}
