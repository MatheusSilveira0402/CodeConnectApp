import 'package:flutter/material.dart';
import '../core/constants.dart';
import 'code_connect_logo.dart';

/// AppBar customizada do CodeConnect com logo e botão de publicar
class CodeConnectAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onPublicarPressed;

  const CodeConnectAppBar({super.key, this.onPublicarPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: UiConstants.appBarHeight,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: UiConstants.paddingSmall,
            horizontal: UiConstants.paddingMedium,
          ),
          child: Column(
            spacing: UiConstants.spacingMedium,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CodeConnectLogo(height: UiConstants.iconSizeSmall),
              OutlinedButton(
                onPressed: onPublicarPressed ?? () {},
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
