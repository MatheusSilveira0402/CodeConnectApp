import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/constants.dart';
import '../core/di/service_locator.dart';
import '../core/validators/field_validators.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../widgets/auth/custom_text_field.dart';
import '../widgets/auth/password_field.dart';
import '../widgets/auth/primary_button.dart';
import '../cubits/auth/auth_cubit.dart';
import '../cubits/auth/auth_state.dart';

/// Tela de login do usuário
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Usando Service Locator para obter a instância singleton do AuthCubit
  late final AuthCubit _authCubit = ServiceLocator.instance.authCubit;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: UiConstants.paddingMedium,
              left: UiConstants.paddingMedium,
              child: Image.asset(
                'lib/assets/icon_logo_transparente.png',
                width: 60,
                height: 60,
                color: Colors.amber,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: UiConstants.paddingMedium,
              right: UiConstants.paddingMedium,
              child: Image.asset(
                'lib/assets/icon_logo_transparente.png',
                width: 60,
                height: 60,
                color: Colors.amber,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(UiConstants.paddingLarge),
                    child: BlocBuilder<AuthCubit, AuthState>(
                      bloc: _authCubit,
                      builder: (context, state) {
                        final isLoading = state is AuthLoading;
                        final errorMessage = state is AuthError
                            ? state.message
                            : null;

                        return Form(
                          key: _formKey,
                          child: Column(
                            spacing: UiConstants.spacingLarge,
                            children: [
                              Image.asset(
                                'lib/assets/login_image.png',
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 8,
                                    children: [
                                      Text(
                                        l10n.btnLogin,
                                        style: const TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.textPrimary,
                                        ),
                                      ),
                                      Text(
                                        l10n.loginWelcome,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: AppTheme.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              CustomTextField(
                                label: l10n.fieldEmailOrUsernameLabel,
                                hint: l10n.fieldEmailHint,
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: Icons.email,
                                validator: FieldValidators.email,
                              ),
                              PasswordField(
                                label: l10n.fieldPasswordLabel,
                                controller: _passwordController,
                                validator: FieldValidators.password,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: _rememberMe,
                                    onChanged: (value) => setState(
                                      () => _rememberMe = value ?? false,
                                    ),
                                    activeColor: AppTheme.primaryColor,
                                  ),
                                  Text(
                                    l10n.rememberMe,
                                    style: const TextStyle(
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                                  const Spacer(),
                                  TextButton(
                                    onPressed: _handleForgotPassword,
                                    child: Text(
                                      l10n.forgotPassword,
                                      style: const TextStyle(
                                        color: AppTheme.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (errorMessage != null)
                                Container(
                                  padding: EdgeInsets.all(
                                    UiConstants.paddingSmall,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(
                                      UiConstants.borderRadiusSmall,
                                    ),
                                    border: Border.all(
                                      color: Colors.red.withValues(alpha: 0.5),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: UiConstants.spacingSmall,
                                      ),
                                      Expanded(
                                        child: Text(
                                          errorMessage,
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              PrimaryButton(
                                label: l10n.btnLogin,
                                icon: Icons.arrow_forward,
                                isLoading: isLoading,
                                onPressed: _handleLogin,
                              ),
                              Row(
                                children: [
                                  const Expanded(
                                    child: Divider(
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: UiConstants.paddingMedium,
                                    ),
                                    child: Text(
                                      l10n.orContinueWith,
                                      style: const TextStyle(
                                        color: AppTheme.textSecondary,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    child: Divider(
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                spacing: UiConstants.spacingMedium,
                                children: [
                                  Expanded(
                                    child: _SocialButton(
                                      icon: Icons.code,
                                      label: l10n.githubLabel,
                                    ),
                                  ),
                                  Expanded(
                                    child: _SocialButton(
                                      icon: Icons.g_mobiledata,
                                      label: l10n.googleLabel,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    l10n.noAccountYet,
                                    style: const TextStyle(
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pushNamed(
                                      context,
                                      AppRoutes.cadastro,
                                    ),
                                    child: Text(
                                      l10n.signUpNow,
                                      style: const TextStyle(
                                        color: AppTheme.primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await _authCubit.login(
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (success && mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  void _handleForgotPassword() {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).forgotPasswordSnack)),
    );
  }
}

/// Widget de botão social reutilizável
class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SocialButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: UiConstants.paddingSmall),
        side: BorderSide(color: AppTheme.textSecondary.withValues(alpha: 0.3)),
      ),
      child: Row(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
