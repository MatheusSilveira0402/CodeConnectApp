import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../theme/app_theme.dart';

/// Widget para título de seção
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: UiConstants.spacingXLarge,
        bottom: UiConstants.paddingMedium,
      ),
      child: Text(title, style: AppTheme.titleMedium),
    );
  }
}
