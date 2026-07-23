import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:code_connect/core/exceptions/api_exception.dart';
import 'package:code_connect/cubits/post_form/post_form_cubit.dart';
import 'package:code_connect/cubits/post_form/post_form_state.dart';
import 'package:code_connect/repositories/blog_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../fixtures.dart';

class MockBlogRepository extends Mock implements IBlogRepository {}

class FakeFile extends Fake implements File {
  @override
  String get path => 'fake/image.png';
}

void main() {
  late MockBlogRepository repository;
  late File image;

  setUpAll(() {
    registerFallbackValue(FakeFile());
  });

  setUp(() {
    repository = MockBlogRepository();
    image = FakeFile();
  });

  group('PostFormCubit.createPost', () {
    blocTest<PostFormCubit, PostFormState>(
      'emite [Loading, Success] quando a criação dá certo',
      setUp: () {
        when(
          () => repository.createPost(
            title: any(named: 'title'),
            body: any(named: 'body'),
            markdown: any(named: 'markdown'),
            image: any(named: 'image'),
          ),
        ).thenAnswer((_) async => buildPost());
      },
      build: () => PostFormCubit(repository),
      act: (cubit) => cubit.createPost(
        title: 'Meu projeto',
        body: 'Descrição',
        markdown: 'React',
        image: image,
      ),
      expect: () => [
        const PostFormLoading(),
        isA<PostFormSuccess>().having((s) => s.post?.title, 'post.title', 'Meu projeto'),
      ],
    );

    blocTest<PostFormCubit, PostFormState>(
      'emite [Loading, Error] quando a API recusa a criação',
      setUp: () {
        when(
          () => repository.createPost(
            title: any(named: 'title'),
            body: any(named: 'body'),
            markdown: any(named: 'markdown'),
            image: any(named: 'image'),
          ),
        ).thenThrow(ApiException(message: 'Arquivo muito grande.', statusCode: 413));
      },
      build: () => PostFormCubit(repository),
      act: (cubit) => cubit.createPost(
        title: 'Meu projeto',
        body: 'Descrição',
        markdown: 'React',
        image: image,
      ),
      expect: () => [
        const PostFormLoading(),
        const PostFormError('Arquivo muito grande.'),
      ],
    );
  });

  group('PostFormCubit.deletePost', () {
    blocTest<PostFormCubit, PostFormState>(
      'emite [Loading, Success] quando a exclusão dá certo',
      setUp: () {
        when(() => repository.deletePost(1)).thenAnswer((_) async {});
      },
      build: () => PostFormCubit(repository),
      act: (cubit) => cubit.deletePost(1),
      expect: () => [
        const PostFormLoading(),
        const PostFormSuccess(null),
      ],
    );

    blocTest<PostFormCubit, PostFormState>(
      'emite [Loading, Error] quando a exclusão falha',
      setUp: () {
        when(
          () => repository.deletePost(1),
        ).thenThrow(ApiException(message: 'Post não encontrado.', statusCode: 404));
      },
      build: () => PostFormCubit(repository),
      act: (cubit) => cubit.deletePost(1),
      expect: () => [
        const PostFormLoading(),
        const PostFormError('Post não encontrado.'),
      ],
    );
  });
}
