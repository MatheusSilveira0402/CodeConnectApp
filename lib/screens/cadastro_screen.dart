import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/constants.dart';
import '../core/di/service_locator.dart';
import '../core/validators/field_validators.dart';
import '../cubits/auth/auth_cubit.dart';
import '../cubits/auth/auth_state.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../widgets/auth/custom_text_field.dart';
import '../widgets/auth/password_field.dart';
import '../widgets/auth/primary_button.dart';

/// Tela de cadastro de novo usuário
class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  // Usando Service Locator para obter a instância singleton do AuthCubit
  late final AuthCubit _authCubit = ServiceLocator.instance.authCubit;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(UiConstants.paddingLarge),
            child: BlocBuilder<AuthCubit, AuthState>(
              bloc: _authCubit,
              builder: (context, state) {
                final isLoading = state is AuthLoading;
                final errorMessage = state is AuthError ? state.message : null;

                return Form(
                  key: _formKey,
                  child: Column(
                    spacing: UiConstants.spacingLarge,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/assets/lampada.png',
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      Column(
                        spacing: 8,
                        children: [
                          Text(
                            l10n.cadastroTitle,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          Text(
                            l10n.cadastroSubtitle,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      CustomTextField(
                        label: l10n.fieldNameLabel,
                        hint: l10n.fieldNameHint,
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        prefixIcon: Icons.person,
                        validator: FieldValidators.fullName,
                      ),
                      CustomTextField(
                        label: l10n.fieldEmailAddressLabel,
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
                      PasswordField(
                        label: l10n.fieldConfirmPasswordLabel,
                        controller: _confirmPasswordController,
                        validator: (value) => FieldValidators.confirmPassword(
                          value,
                          _passwordController.text,
                        ),
                      ),
                      if (errorMessage != null)
                        Container(
                          padding: EdgeInsets.all(UiConstants.paddingSmall),
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
                              SizedBox(width: UiConstants.spacingSmall),
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
                        label: l10n.btnCadastrar,
                        icon: Icons.arrow_forward,
                        isLoading: isLoading,
                        onPressed: _handleRegister,
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(color: AppTheme.textSecondary),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: UiConstants.paddingMedium,
                            ),
                            child: Text(
                              l10n.orCreateAccountWith,
                              style: const TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Divider(color: AppTheme.textSecondary),
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
                            l10n.alreadyHaveAccount,
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, AppRoutes.login),
                            child: Text(
                              l10n.loginNow,
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
    );
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await _authCubit.register(
      _nameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
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
