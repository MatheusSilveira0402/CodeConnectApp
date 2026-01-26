// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perfil_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PerfilStore on _PerfilStore, Store {
  Computed<bool>? _$hasUserComputed;

  @override
  bool get hasUser => (_$hasUserComputed ??= Computed<bool>(
    () => super.hasUser,
    name: '_PerfilStore.hasUser',
  )).value;

  late final _$userAtom = Atom(name: '_PerfilStore.user', context: context);

  @override
  UserModel? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_PerfilStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_PerfilStore.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$loadUserProfileAsyncAction = AsyncAction(
    '_PerfilStore.loadUserProfile',
    context: context,
  );

  @override
  Future<void> loadUserProfile() {
    return _$loadUserProfileAsyncAction.run(() => super.loadUserProfile());
  }

  late final _$updateAvatarAsyncAction = AsyncAction(
    '_PerfilStore.updateAvatar',
    context: context,
  );

  @override
  Future<void> updateAvatar(String path) {
    return _$updateAvatarAsyncAction.run(() => super.updateAvatar(path));
  }

  late final _$_PerfilStoreActionController = ActionController(
    name: '_PerfilStore',
    context: context,
  );

  @override
  void clearError() {
    final _$actionInfo = _$_PerfilStoreActionController.startAction(
      name: '_PerfilStore.clearError',
    );
    try {
      return super.clearError();
    } finally {
      _$_PerfilStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
hasUser: ${hasUser}
    ''';
  }
}
