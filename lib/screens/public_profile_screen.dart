import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../core/di/service_locator.dart';
import '../core/utils/api_helper.dart';
import '../l10n/app_localizations.dart';
import '../models/public_user_model.dart';
import '../theme/app_theme.dart';

/// Tela de perfil público de outro dev, aberta ao tocar num marcador
/// na tela "Devs por perto".
class PublicProfileScreen extends StatefulWidget {
  final String userId;

  const PublicProfileScreen({super.key, required this.userId});

  @override
  State<PublicProfileScreen> createState() => _PublicProfileScreenState();
}

class _PublicProfileScreenState extends State<PublicProfileScreen> {
  late Future<PublicUserModel> _future;

  @override
  void initState() {
    super.initState();
    _future = ServiceLocator.instance.userRepository.getUserById(
      widget.userId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppTheme.textColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<PublicUserModel>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppTheme.primaryColor,
                ),
              ),
            );
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    l10n.userNotFound,
                    style: const TextStyle(color: AppTheme.textColor),
                  ),
                ],
              ),
            );
          }

          final user = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: AppTheme.primaryColor.withValues(
                    alpha: 0.2,
                  ),
                  backgroundImage: user.avatar != null
                      ? NetworkImage(ApiHelper.getAvatarUrl(user.avatar))
                      : null,
                  child: user.avatar == null
                      ? const Icon(
                          Icons.person,
                          size: 60,
                          color: AppTheme.primaryColor,
                        )
                      : null,
                ),
                const SizedBox(height: 16),
                Text(user.name, style: AppTheme.titleLargeWhite),
                if (user.username != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '@${user.username}',
                      style: const TextStyle(color: AppTheme.textSecondary),
                    ),
                  ),
                const SizedBox(height: 8),
                Text(
                  l10n.memberSince(DateFormat.yMMMM(l10n.localeName).format(user.createdAt)),
                  style: const TextStyle(color: AppTheme.textSecondary),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
