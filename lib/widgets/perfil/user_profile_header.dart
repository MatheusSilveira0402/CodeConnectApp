import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../core/utils/api_helper.dart';
import '../../models/user_model.dart';
import '../../theme/app_theme.dart';

/// Widget de cabeçalho do perfil com avatar e informações
class UserProfileHeader extends StatelessWidget {
  final UserModel user;
  final VoidCallback? onAvatarTap;

  const UserProfileHeader({super.key, required this.user, this.onAvatarTap});

  ImageProvider? _getAvatarImage() {
    if (user.avatar == null || user.avatar!.isEmpty) {
      return null;
    }

    // Se começa com http, é URL remota
    if (user.avatar!.startsWith('http://') ||
        user.avatar!.startsWith('https://')) {
      return NetworkImage(ApiHelper.getAvatarUrl(user.avatar));
    }

    // Se começa com lib/, é asset local
    if (user.avatar!.startsWith('lib/')) {
      return AssetImage(user.avatar!);
    }

    // Assume que é caminho remoto
    return NetworkImage(ApiHelper.getAvatarUrl(user.avatar));
  }

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
            backgroundImage: _getAvatarImage(),
            child: user.avatar == null || user.avatar!.isEmpty
                ? const Icon(
                    Icons.person,
                    size: 60,
                    color: AppTheme.primaryColor,
                  )
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
