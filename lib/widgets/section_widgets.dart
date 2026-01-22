import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 16),
      child: Text(title, style: AppTheme.titleMedium),
    );
  }
}

class SectionContent extends StatelessWidget {
  final String content;

  const SectionContent(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(content, style: AppTheme.bodyMedium);
  }
}

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
      margin: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
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
                borderRadius: BorderRadius.circular(16),
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
