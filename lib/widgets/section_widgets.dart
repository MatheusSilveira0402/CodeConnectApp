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
      padding: EdgeInsets.only(
        top: UiConstants.spacingXLarge,
        bottom: UiConstants.paddingMedium,
      ),
      child: Text(title, style: AppTheme.titleMedium),
    );
  }
}

/// Widget para conteúdo de seção
class SectionContent extends StatelessWidget {
  final String content;

  const SectionContent(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(content, style: AppTheme.bodyMedium);
  }
}

/// Widget para exibir imagens com destaque
class FeatureImage extends StatelessWidget {
  final IconData? icon;
  final String? imagePath;
  final double height;
  final List<Color>? gradientColors;

  const FeatureImage({
    super.key,
    this.icon,
    this.imagePath,
    this.height = 200,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(vertical: UiConstants.spacingXLarge),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(UiConstants.borderRadiusMedium),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors:
              gradientColors ??
              [
                AppTheme.primaryColor.withValues(alpha: 0.2),
                AppTheme.backgroundColor,
              ],
        ),
      ),
      child: Center(
        child: imagePath != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(
                  UiConstants.borderRadiusMedium,
                ),
                child: Image.asset(
                  imagePath!,
                  height: height * 0.8,
                  fit: BoxFit.contain,
                ),
              )
            : Icon(
                icon ?? Icons.code,
                size: height * 0.4,
                color: AppTheme.primaryColor.withValues(alpha: 0.5),
              ),
      ),
    );
  }
}
