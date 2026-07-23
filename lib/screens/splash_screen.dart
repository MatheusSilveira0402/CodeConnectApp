import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/constants.dart';
import '../core/di/service_locator.dart';
import '../cubits/auth/auth_cubit.dart';
import '../cubits/auth/auth_state.dart';
import '../theme/app_theme.dart';
import '../widgets/app_logo.dart';

/// Tela de abertura: verifica de forma assíncrona se existe uma sessão
/// válida salva no dispositivo e redireciona sem exigir login de novo.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final AuthCubit _authCubit = ServiceLocator.instance.authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit.checkAuthStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: BlocListener<AuthCubit, AuthState>(
        bloc: _authCubit,
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          } else if (state is AuthUnauthenticated) {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          }
        },
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppLogo(height: UiConstants.iconSizeLarge),
              SizedBox(height: UiConstants.spacingLarge),
              CircularProgressIndicator(color: AppTheme.primaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
