import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../theme/app_theme.dart';

/// Card de ações do perfil (Meus Projetos e Compartilhados)
class ProfileActionsCard extends StatelessWidget {
  final VoidCallback? onMyProjectsTap;
  final VoidCallback? onSharedTap;

  const ProfileActionsCard({super.key, this.onMyProjectsTap, this.onSharedTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(UiConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(UiConstants.borderRadiusMedium),
      ),
      child: Column(
        spacing: UiConstants.spacingSmall,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Meus projetos',
            style: AppTheme.titleMedium.copyWith(fontSize: 18),
          ),
          _ActionButton(label: 'Aprovados', onTap: onMyProjectsTap),
          _ActionButton(label: 'Compartilhados', onTap: onSharedTap),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const _ActionButton({required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(UiConstants.borderRadiusSmall),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: UiConstants.paddingSmall,
          horizontal: UiConstants.paddingMedium,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(UiConstants.borderRadiusSmall),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: AppTheme.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
