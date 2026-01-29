import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Widget para conteúdo de seção
class SectionContent extends StatelessWidget {
  final String content;

  const SectionContent(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(content, style: AppTheme.bodyMedium);
  }
}
