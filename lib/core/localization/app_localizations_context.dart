import 'package:flutter/widgets.dart';
import '../../l10n/app_localizations.dart';

/// Chave de navegação global do app, usada para obter o [BuildContext]
/// atual fora da árvore de widgets (validators, repositórios, cubits).
final navigatorKey = GlobalKey<NavigatorState>();

/// Acesso às strings localizadas fora da árvore de widgets.
///
/// Só pode ser usado depois que o [MaterialApp] montou (ou seja, não
/// durante o `main()`). Nas camadas de validação/repositório/cubit isso
/// sempre acontece após a UI já estar de pé.
AppLocalizations get l10n {
  final context = navigatorKey.currentContext;
  if (context == null) {
    throw StateError(
      'AppLocalizations acessado antes do MaterialApp ser montado',
    );
  }
  return AppLocalizations.of(context);
}
