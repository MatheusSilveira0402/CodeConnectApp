import '../localization/app_localizations_context.dart';

/// Validadores de campos de formulário seguindo Clean Code
/// Cada método retorna null se válido ou uma mensagem de erro
class FieldValidators {
  FieldValidators._();

  /// Valida se o campo não está vazio
  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return l10n.validatorFieldRequired(fieldName ?? l10n.defaultFieldName);
    }
    return null;
  }

  /// Valida formato de email
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return l10n.validatorEmailRequired;
    }

    final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

    if (!emailRegex.hasMatch(value)) {
      return l10n.validatorEmailInvalid;
    }

    return null;
  }

  /// Valida senha com requisitos mínimos
  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return l10n.validatorPasswordRequired;
    }

    if (value.length < minLength) {
      return l10n.validatorPasswordMinLength(minLength);
    }

    return null;
  }

  /// Valida confirmação de senha
  static String? confirmPassword(String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return l10n.validatorConfirmPasswordRequired;
    }

    if (value != originalPassword) {
      return l10n.validatorPasswordsDontMatch;
    }

    return null;
  }

  /// Valida nome completo (mínimo 2 palavras)
  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return l10n.validatorNameRequired;
    }

    final parts = value.trim().split(' ');
    if (parts.length < 2) {
      return l10n.validatorFullNameRequired;
    }

    if (value.trim().length < 3) {
      return l10n.validatorNameTooShort;
    }

    return null;
  }

  /// Valida comprimento mínimo
  static String? minLength(
    String? value,
    int minLength, {
    required String fieldName,
  }) {
    if (value == null || value.isEmpty) {
      return l10n.validatorFieldRequired(fieldName);
    }

    if (value.length < minLength) {
      return l10n.validatorMinLength(fieldName, minLength);
    }

    return null;
  }

  /// Valida comprimento máximo
  static String? maxLength(
    String? value,
    int maxLength, {
    required String fieldName,
  }) {
    if (value != null && value.length > maxLength) {
      return l10n.validatorMaxLength(fieldName, maxLength);
    }

    return null;
  }

  /// Combina múltiplos validadores
  static String? Function(String?) combine(
    List<String? Function(String?)> validators,
  ) {
    return (value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) {
          return result;
        }
      }
      return null;
    };
  }
}
