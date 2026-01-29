import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../theme/app_theme.dart';

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
      margin: const EdgeInsets.symmetric(vertical: UiConstants.spacingXLarge),
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
