import 'package:code_connect/core/di/service_locator.dart';
import 'package:code_connect/l10n/app_localizations.dart';
import 'package:code_connect/repositories/blog_repository.dart';
import 'package:code_connect/repositories/user_repository.dart';
import 'package:code_connect/screens/criar_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements IUserRepository {}

class MockBlogRepository extends Mock implements IBlogRepository {}

void main() {
  setUp(() {
    ServiceLocator.instance.reset();
    ServiceLocator.instance.initialize(
      userRepository: MockUserRepository(),
      blogRepository: MockBlogRepository(),
      connectivityStream: const Stream.empty(),
    );
  });

  Widget buildTestApp() {
    return const MaterialApp(
      locale: Locale('pt'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: CriarPostScreen(),
    );
  }

  testWidgets(
    'mostra as mensagens de validação quando os campos estão vazios',
    (tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.byType(ElevatedButton));
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Por favor, insira o título'), findsOneWidget);
      expect(find.text('Por favor, insira a descrição'), findsOneWidget);
      expect(find.text('Por favor, insira as tags'), findsOneWidget);
    },
  );

  testWidgets(
    'mostra aviso pra selecionar imagem quando os textos estão preenchidos mas falta a capa',
    (tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'React fácil de usar').first,
        'Meu projeto incrível',
      );
      await tester.enterText(
        find.byType(TextFormField).at(1),
        'Descrição do projeto',
      );
      await tester.enterText(find.byType(TextFormField).at(2), 'React');

      await tester.ensureVisible(find.byType(ElevatedButton));
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(
        find.text('Por favor, selecione uma imagem de capa'),
        findsOneWidget,
      );
    },
  );
}
