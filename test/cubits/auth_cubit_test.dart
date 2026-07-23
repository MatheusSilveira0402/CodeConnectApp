import 'package:bloc_test/bloc_test.dart';
import 'package:code_connect/core/exceptions/api_exception.dart';
import 'package:code_connect/cubits/auth/auth_cubit.dart';
import 'package:code_connect/cubits/auth/auth_state.dart';
import 'package:code_connect/repositories/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../fixtures.dart';

class MockUserRepository extends Mock implements IUserRepository {}

void main() {
  late MockUserRepository repository;

  setUp(() {
    repository = MockUserRepository();
  });

  group('AuthCubit.login', () {
    blocTest<AuthCubit, AuthState>(
      'emite [AuthLoading, AuthAuthenticated] quando o login dá certo',
      setUp: () {
        when(
          () => repository.login('ana@codeconnect.com', '123456'),
        ).thenAnswer((_) async => buildUser());
      },
      build: () => AuthCubit(repository),
      act: (cubit) => cubit.login('ana@codeconnect.com', '123456'),
      expect: () => [
        const AuthLoading(),
        isA<AuthAuthenticated>().having(
          (s) => s.user.email,
          'user.email',
          'ana@codeconnect.com',
        ),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emite [AuthLoading, AuthError] quando a API recusa as credenciais',
      setUp: () {
        when(() => repository.login(any(), any())).thenThrow(
          UnauthorizedException('Email ou senha incorretos.'),
        );
      },
      build: () => AuthCubit(repository),
      act: (cubit) => cubit.login('ana@codeconnect.com', 'senha-errada'),
      expect: () => [
        const AuthLoading(),
        const AuthError('Email ou senha incorretos.'),
      ],
    );

    test('retorna false quando o login falha', () async {
      when(
        () => repository.login(any(), any()),
      ).thenThrow(UnauthorizedException('Email ou senha incorretos.'));

      final cubit = AuthCubit(repository);
      final success = await cubit.login('ana@codeconnect.com', 'senha-errada');

      expect(success, isFalse);
      await cubit.close();
    });

    test('retorna true quando o login dá certo', () async {
      when(
        () => repository.login('ana@codeconnect.com', '123456'),
      ).thenAnswer((_) async => buildUser());

      final cubit = AuthCubit(repository);
      final success = await cubit.login('ana@codeconnect.com', '123456');

      expect(success, isTrue);
      await cubit.close();
    });
  });

  group('AuthCubit.register', () {
    blocTest<AuthCubit, AuthState>(
      'emite [AuthLoading, AuthAuthenticated] quando o cadastro dá certo',
      setUp: () {
        when(
          () => repository.register('Ana Paula', 'ana@codeconnect.com', '123456'),
        ).thenAnswer((_) async => buildUser());
      },
      build: () => AuthCubit(repository),
      act: (cubit) =>
          cubit.register('Ana Paula', 'ana@codeconnect.com', '123456'),
      expect: () => [
        const AuthLoading(),
        isA<AuthAuthenticated>(),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emite [AuthLoading, AuthError] quando o email já está em uso',
      setUp: () {
        when(() => repository.register(any(), any(), any())).thenThrow(
          ApiException(message: 'Este email já está cadastrado.', statusCode: 409),
        );
      },
      build: () => AuthCubit(repository),
      act: (cubit) =>
          cubit.register('Ana Paula', 'ana@codeconnect.com', '123456'),
      expect: () => [
        const AuthLoading(),
        const AuthError('Este email já está cadastrado.'),
      ],
    );
  });

  group('AuthCubit.logout', () {
    blocTest<AuthCubit, AuthState>(
      'emite [AuthUnauthenticated] quando o logout dá certo',
      setUp: () {
        when(() => repository.logout()).thenAnswer((_) async {});
      },
      build: () => AuthCubit(repository),
      act: (cubit) => cubit.logout(),
      expect: () => [const AuthUnauthenticated()],
    );

    blocTest<AuthCubit, AuthState>(
      'emite [AuthError] quando o logout falha',
      setUp: () {
        when(
          () => repository.logout(),
        ).thenThrow(ApiException(message: 'Erro de conexão.'));
      },
      build: () => AuthCubit(repository),
      act: (cubit) => cubit.logout(),
      expect: () => [const AuthError('Erro de conexão.')],
    );
  });
}
