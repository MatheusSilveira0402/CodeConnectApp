import 'package:flutter/material.dart';

/// Widget que exibe o logo do CodeConnect
class CodeConnectLogo extends StatelessWidget {
  final double height;

  const CodeConnectLogo({super.key, this.height = 24});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'lib/assets/logo.png',
      height: height,
      fit: BoxFit.contain,
    );
  }
}
