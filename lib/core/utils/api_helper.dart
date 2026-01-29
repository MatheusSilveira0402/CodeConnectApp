import '../http/http_client.dart';

/// Helper para construção de URLs de recursos
class ApiHelper {
  ApiHelper._();

  /// Constrói URL completa para imagem
  ///
  /// Se a URL já for completa (http/https), retorna como está.
  /// Se for relativa, adiciona o baseUrl.
  static String getImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return '';
    }

    // Se contém localhost, substitui pelo IP correto
    if (imagePath.contains('localhost')) {
      return imagePath.replaceAll('localhost:3000', '192.168.1.233:3000');
    }

    // Se já é uma URL completa, retorna como está
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return imagePath;
    }

    // Remove barra inicial se houver
    final cleanPath = imagePath.startsWith('/')
        ? imagePath.substring(1)
        : imagePath;

    // Constrói URL completa usando a baseUrl do HttpClient
    return '${HttpClient.baseUrl}/$cleanPath';
  }

  /// Constrói URL completa para avatar
  static String getAvatarUrl(String? avatarPath) {
    return getImageUrl(avatarPath);
  }
}
