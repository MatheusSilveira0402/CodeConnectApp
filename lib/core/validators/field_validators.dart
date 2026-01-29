/// Validadores de campos de formulário seguindo Clean Code
/// Cada método retorna null se válido ou uma mensagem de erro
class FieldValidators {
  FieldValidators._();

  /// Valida se o campo não está vazio
  static String? required(String? value, {String fieldName = 'Campo'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName é obrigatório';
    }
    return null;
  }

  /// Valida formato de email
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email é obrigatório';
    }

    final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

    if (!emailRegex.hasMatch(value)) {
      return 'Email inválido';
    }

    return null;
  }

  /// Valida senha com requisitos mínimos
  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'Senha é obrigatória';
    }

    if (value.length < minLength) {
      return 'Senha deve ter pelo menos $minLength caracteres';
    }

    return null;
  }

  /// Valida confirmação de senha
  static String? confirmPassword(String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Confirmação de senha é obrigatória';
    }

    if (value != originalPassword) {
      return 'As senhas não coincidem';
    }

    return null;
  }

  /// Valida nome completo (mínimo 2 palavras)
  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nome é obrigatório';
    }

    final parts = value.trim().split(' ');
    if (parts.length < 2) {
      return 'Digite seu nome completo';
    }

    if (value.trim().length < 3) {
      return 'Nome muito curto';
    }

    return null;
  }

  /// Valida comprimento mínimo
  static String? minLength(
    String? value,
    int minLength, {
    String fieldName = 'Campo',
  }) {
    if (value == null || value.isEmpty) {
      return '$fieldName é obrigatório';
    }

    if (value.length < minLength) {
      return '$fieldName deve ter pelo menos $minLength caracteres';
    }

    return null;
  }

  /// Valida comprimento máximo
  static String? maxLength(
    String? value,
    int maxLength, {
    String fieldName = 'Campo',
  }) {
    if (value != null && value.length > maxLength) {
      return '$fieldName deve ter no máximo $maxLength caracteres';
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
