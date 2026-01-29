import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../screens/criar_post_screen.dart';
import 'app_logo.dart';

/// AppBar customizada do CodeConnect com logo e botão de publicar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onPublicarPressed;

  const CustomAppBar({super.key, this.onPublicarPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: UiConstants.appBarHeight,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: UiConstants.paddingSmall,
            horizontal: UiConstants.paddingMedium,
          ),
          child: Column(
            spacing: UiConstants.spacingMedium,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppLogo(height: UiConstants.iconSizeSmall),
              OutlinedButton(
                onPressed: () async {
                  if (onPublicarPressed != null) {
                    onPublicarPressed!();
                  } else {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CriarPostScreen(),
                      ),
                    );
                  }
                },
                child: const Text(AppStrings.btnPublicar),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(UiConstants.appBarHeight);
}
