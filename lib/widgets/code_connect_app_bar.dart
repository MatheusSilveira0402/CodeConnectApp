import 'package:flutter/material.dart';
import 'code_connect_logo.dart';

class CodeConnectAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onPublicarPressed;

  const CodeConnectAppBar({super.key, this.onPublicarPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 130,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CodeConnectLogo(height: 36),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: onPublicarPressed ?? () {},
                child: const Text('Publicar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(130);
}
