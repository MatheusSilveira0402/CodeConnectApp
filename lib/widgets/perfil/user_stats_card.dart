import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../theme/app_theme.dart';

/// Card de estatísticas do usuário
class UserStatsCard extends StatelessWidget {
  final int projectsCount;
  final int connectionsCount;

  const UserStatsCard({
    super.key,
    required this.projectsCount,
    required this.connectionsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(UiConstants.paddingLarge),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(UiConstants.borderRadiusMedium),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            icon: Icons.folder,
            value: projectsCount,
            label: 'Projetos',
          ),
          Container(
            width: 1,
            height: 40,
            color: AppTheme.textSecondary.withValues(alpha: 0.3),
          ),
          _StatItem(
            icon: Icons.people,
            value: connectionsCount,
            label: 'Conexões',
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final int value;
  final String label;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: UiConstants.spacingSmall,
      children: [
        Icon(icon, color: AppTheme.primaryColor, size: 32),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
        ),
      ],
    );
  }
}
