import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendure_flutter_app/core/theme/app_colors.dart';
import 'package:vendure_flutter_app/core/theme/app_spacing.dart';
import 'package:vendure_flutter_app/core/theme/app_text_styles.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/payment_methods_controller.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/payment_method.dart';

class PaymentMethodCard extends ConsumerWidget {
  const PaymentMethodCard({
    super.key,
    required this.method,
    required this.isSelected,
  });

  final PaymentMethod method;
  final bool isSelected;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => ref
          .read(paymentMethodsControllerProvider.notifier)
          .selectPaymentMethod(method),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.m),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSpacing.radiusCard + 4),
          border: Border.all(
            color: isSelected ? AppColors.primaryNavy : AppColors.neutralGray,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primaryNavy.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // Radio-like indicator
            Container(
              width: 22,
              height: 22,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryNavy
                      : AppColors.grey.withValues(alpha: 0.4),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryNavy,
                      ),
                    )
                  : null,
            ),
            AppSpacing.hM,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.name,
                    style: AppTextStyles.h3.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (method.description != null &&
                      method.description!.isNotEmpty)
                    Text(
                      method.description!,
                      style: AppTextStyles.label.copyWith(
                        color: isSelected
                            ? AppColors.primaryNavy.withValues(alpha: 0.8)
                            : AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              _getPaymentIcon(method.code),
              color: AppColors.textSecondary.withValues(alpha: 0.5),
              size: 28,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getPaymentIcon(String code) {
    final lowerCode = code.toLowerCase();
    if (lowerCode.contains('stripe')) return Icons.credit_card;
    if (lowerCode.contains('paypal')) return Icons.payment;
    if (lowerCode.contains('cod') || lowerCode.contains('cash')) {
      return Icons.payments_outlined;
    }
    return Icons.account_balance_wallet_outlined;
  }
}
