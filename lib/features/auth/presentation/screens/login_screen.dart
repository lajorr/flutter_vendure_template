import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vendure_flutter_app/app/router/app_routes.dart';
import 'package:vendure_flutter_app/core/theme/app_colors.dart';
import 'package:vendure_flutter_app/core/theme/app_spacing.dart';
import 'package:vendure_flutter_app/core/theme/app_text_styles.dart';
import 'package:vendure_flutter_app/core/utils/validation_mixin.dart';
import 'package:vendure_flutter_app/features/auth/application/controllers/auth_controllers.dart';
import 'package:vendure_flutter_app/features/auth/presentation/widgets/social_button.dart';
import 'package:vendure_flutter_app/gen/assets.gen.dart';
import 'package:vendure_flutter_app/shared/widgets/app_button.dart';
import 'package:vendure_flutter_app/shared/widgets/custom_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      ref
          .read(loginControllerProvider.notifier)
          .login(_emailController.text.trim(), _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginControllerProvider);
    final isLoading = loginState.isLoading;

    ref.listen(loginControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
              backgroundColor: AppColors.error,
            ),
          );
        },
        data: (_) {
          if (previous?.isLoading ?? false) {
            context.goNamed(AppRoute.dashboard.name);
          }
        },
      );
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AppSpacing.vXL,
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.primaryNavy,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryNavy.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.shopping_bag,
                    color: AppColors.white,
                    size: 40,
                  ),
                ),
                AppSpacing.vL,
                Text(
                  'ShopModern',
                  style: AppTextStyles.h1.copyWith(fontSize: 28),
                  textAlign: TextAlign.center,
                ),
                AppSpacing.vXS,
                Text(
                  'Welcome back! Please enter your details.',
                  style: AppTextStyles.bodySmall,
                  textAlign: TextAlign.center,
                ),
                AppSpacing.vXL,
                CustomTextField(
                  controller: _emailController,
                  label: 'Email Address',
                  hint: 'name@example.com',
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: AppColors.textSecondary,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  fillColor: AppColors.white,
                  validator: (value) => validateEmail(value),
                ),
                AppSpacing.vL,
                CustomTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'Enter your password',
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.textSecondary,
                  ),
                  obscureText: true,
                  fillColor: AppColors.white,
                  validator: (value) => validateRequired(value, 'Password'),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Navigate to Forgot Password screen
                    },
                    child: Text(
                      'Forgot Password?',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primaryNavy,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                AppSpacing.vM,
                AppButton(
                  text: 'Sign In',
                  icon: Icons.login,
                  isLoading: isLoading,
                  onPressed: isLoading ? null : _onLogin,
                ),
                AppSpacing.vXL,
                Row(
                  children: [
                    const Expanded(
                      child: Divider(color: AppColors.primaryLight),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'OR CONTINUE WITH',
                        style: AppTextStyles.label.copyWith(fontSize: 10),
                      ),
                    ),
                    const Expanded(
                      child: Divider(color: AppColors.primaryLight),
                    ),
                  ],
                ),
                AppSpacing.vXL,
                Row(
                  children: [
                    SocialButton(
                      text: 'Google',
                      icon: Assets.icons.googleIcon.svg(),
                      onPressed: () {},
                    ),
                    AppSpacing.hM,
                    SocialButton(
                      text: 'Apple',
                      icon: const Icon(
                        Icons.apple,
                        color: AppColors.black,
                        size: 24,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                AppSpacing.vS,
                TextButton(
                  onPressed: () {
                    context.goNamed(AppRoute.dashboard.name);
                  },
                  child: Text(
                    "Continue As Guest",
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                AppSpacing.vS,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: AppTextStyles.bodySmall,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.goNamed(AppRoute.signup.name);
                      },
                      child: Text(
                        'Sign up for free',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primaryNavy,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                AppSpacing.vL,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
