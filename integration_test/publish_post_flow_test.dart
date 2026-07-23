// Teste de integração (bônus): cobre o fluxo completo de publicar um
// projeto — abrir a tela, preencher os campos e confirmar o sucesso com
// a API mockada — de ponta a ponta, como o usuário realmente usaria o app.
//
// Usa o fluxo de EDIÇÃO (CriarPostScreen com um post existente) porque a
// escolha de imagem (câmera/galeria) abre um seletor nativo do sistema
// operacional, que não é automatizável num teste de integração sem mocks
// de plugin adicionais — na edição a capa já existe, então esse passo é
// pulado e o formulário pode ser preenchido e enviado de ponta a ponta.
//
// Para rodar: flutter test integration_test/publish_post_flow_test.dart
// (precisa de um emulador/dispositivo conectado).

import 'package:code_connect/core/di/service_locator.dart';
import 'package:code_connect/l10n/app_localizations.dart';
import 'package:code_connect/models/blog_post_model.dart';
import 'package:code_connect/repositories/blog_repository.dart';
import 'package:code_connect/repositories/user_repository.dart';
import 'package:code_connect/screens/criar_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements IUserRepository {}

class MockBlogRepository extends Mock implements IBlogRepository {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockBlogRepository blogRepository;

  final existingPost = BlogPostModel(
    id: 42,
    cover: 'https://example.com/cover.png',
    imageUrl: 'https://example.com/cover.png',
    title: 'Projeto antigo',
    slug: 'projeto-antigo',
    body: 'Descrição antiga',
    markdown: 'React',
    likes: 0,
    author: const PostAuthor(id: 'user-1', name: 'Ana Paula'),
    createdAt: DateTime(2024, 1, 1),
    updatedAt: DateTime(2024, 1, 1),
  );

  setUp(() {
    blogRepository = MockBlogRepository();
    ServiceLocator.instance.reset();
    ServiceLocator.instance.initialize(
      userRepository: MockUserRepository(),
      blogRepository: blogRepository,
      connectivityStream: const Stream.empty(),
    );
  });

  testWidgets(
    'publica (atualiza) um projeto de ponta a ponta com a API mockada',
    (tester) async {
      final updatedPost = BlogPostModel(
        id: existingPost.id,
        cover: existingPost.cover,
        imageUrl: existingPost.imageUrl,
        title: 'Projeto atualizado via teste',
        slug: existingPost.slug,
        body: 'Nova descrição do projeto',
        markdown: 'Flutter',
        likes: existingPost.likes,
        author: existingPost.author,
        createdAt: existingPost.createdAt,
        updatedAt: DateTime.now(),
      );

      when(
        () => blogRepository.updatePost(
          id: existingPost.id,
          title: any(named: 'title'),
          body: any(named: 'body'),
          markdown: any(named: 'markdown'),
        ),
      ).thenAnswer((_) async => updatedPost);

      // Abre a tela de criação/edição a partir de uma tela inicial
      // qualquer, pra existir uma rota anterior pra onde o Navigator.pop
      // de sucesso possa voltar.
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('pt'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CriarPostScreen(post: existingPost),
                    ),
                  ),
                  child: const Text('abrir'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // 1. Abre a tela de edição do projeto
      await tester.tap(find.text('abrir'));
      await tester.pumpAndSettle();
      expect(find.byType(CriarPostScreen), findsOneWidget);

      // 2. Preenche os campos
      await tester.enterText(
        find.byType(TextFormField).at(0),
        'Projeto atualizado via teste',
      );
      await tester.enterText(
        find.byType(TextFormField).at(1),
        'Nova descrição do projeto',
      );
      await tester.enterText(find.byType(TextFormField).at(2), 'Flutter');

      // 3. Confirma o envio
      final publishButton = find.widgetWithText(ElevatedButton, 'Atualizar');
      await tester.ensureVisible(publishButton);
      await tester.tap(publishButton);
      await tester.pumpAndSettle();

      // 4. Confirma sucesso: a API mockada foi chamada com os dados certos
      // e a tela voltou pra rota anterior
      verify(
        () => blogRepository.updatePost(
          id: existingPost.id,
          title: 'Projeto atualizado via teste',
          body: 'Nova descrição do projeto',
          markdown: 'Flutter',
        ),
      ).called(1);
      expect(find.byType(CriarPostScreen), findsNothing);
      expect(find.text('abrir'), findsOneWidget);
    },
  );
}
