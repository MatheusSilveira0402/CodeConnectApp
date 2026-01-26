import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../models/user_model.dart';
import '../../theme/app_theme.dart';

/// Widget de cabeçalho do perfil com avatar e informações
class UserProfileHeader extends StatelessWidget {
  final UserModel user;
  final VoidCallback? onAvatarTap;

  const UserProfileHeader({super.key, required this.user, this.onAvatarTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: UiConstants.spacingMedium,
      children: [
        GestureDetector(
          onTap: onAvatarTap,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.2),
            backgroundImage: user.avatar != null
                ? AssetImage(user.avatar!)
                : null,
            child: user.avatar == null
                ? Icon(Icons.person, size: 60, color: AppTheme.primaryColor)
                : null,
          ),
        ),
        Text(
          user.name,
          style: AppTheme.titleLargeWhite,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
