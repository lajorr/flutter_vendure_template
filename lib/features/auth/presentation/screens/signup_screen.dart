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

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen>
    with ValidationMixin {
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

  void _onSignUp() {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text.trim();
      final nameParts = name.split(' ');
      final firstName = nameParts.first;
      final lastName = nameParts.length > 1
          ? nameParts.sublist(1).join(' ')
          : '';

      ref
          .read(signUpControllerProvider.notifier)
          .signUp(
            firstName: firstName,
            lastName: lastName,
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final signupState = ref.watch(signUpControllerProvider);
    final isLoading = signupState.isLoading;

    ref.listen(signUpControllerProvider, (previous, next) {
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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Account created successfully! Please check your email for verification.',
                ),
                backgroundColor: AppColors.successGreen,
              ),
            );
            context.goNamed(AppRoute.login.name);
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppSpacing.vXL,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.primaryNavy,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryNavy.withValues(alpha: 0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.shopping_bag,
                      color: AppColors.white,
                      size: 30,
                    ),
                  ),
                ),
                AppSpacing.vL,
                Text(
                  'Join Us',
                  style: AppTextStyles.h1.copyWith(fontSize: 28),
                  textAlign: TextAlign.left,
                ),
                AppSpacing.vXS,
                Text(
                  'Start your premium shopping journey today.',
                  style: AppTextStyles.bodySmall,
                  textAlign: TextAlign.left,
                ),
                AppSpacing.vXL,
                CustomTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  hint: 'John Doe',
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: AppColors.textSecondary,
                  ),
                  fillColor: AppColors.white,
                  validator: (value) => validateRequired(value, 'Full name'),
                ),
                AppSpacing.vL,
                CustomTextField(
                  controller: _emailController,
                  label: 'Email Address',
                  hint: 'example@email.com',
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
                  hint: '********',
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.textSecondary,
                  ),
                  obscureText: true,
                  fillColor: AppColors.white,
                  validator: (value) => validatePassword(value),
                ),
                AppSpacing.vL,
                CustomTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirm Password',
                  hint: '*********',
                  prefixIcon: const Icon(
                    Icons.lock_reset_outlined,
                    color: AppColors.textSecondary,
                  ),
                  obscureText: true,
                  fillColor: AppColors.white,
                  validator: (value) => validateMatch(
                    value,
                    _passwordController.text,
                    'Passwords',
                  ),
                ),
                AppSpacing.vXL,
                AppButton(
                  text: 'Sign Up',
                  icon: Icons.arrow_forward,
                  isLoading: isLoading,
                  onPressed: isLoading ? null : _onSignUp,
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
                    const SizedBox(width: 16),
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
                AppSpacing.vXL,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: AppTextStyles.bodySmall,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.goNamed(AppRoute.login.name);
                      },
                      child: Text(
                        'Log In',
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
