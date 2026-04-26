import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vendure_flutter_app/app/router/app_routes.dart';
import 'package:vendure_flutter_app/core/theme/app_colors.dart';
import 'package:vendure_flutter_app/core/theme/app_spacing.dart';
import 'package:vendure_flutter_app/core/theme/app_text_styles.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_controller.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_state.dart';
import 'package:vendure_flutter_app/features/customer/presentation/screens/set_guest_customer_screen.dart';
import 'package:vendure_flutter_app/shared/widgets/custom_container.dart';

class SetCustomerInformationSection extends ConsumerWidget {
  const SetCustomerInformationSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartControllerProvider);
    final customer = cartState.customer;

    final hasCustomer =
        customer != null &&
        customer.firstName.isNotEmpty &&
        customer.lastName.isNotEmpty &&
        customer.emailAddress.isNotEmpty;

    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Customer Information', style: AppTextStyles.h3),
          AppSpacing.vM,
          InkWell(
            onTap: () {
              context.pushNamed(
                AppRoute.setGuestCustomer.name,
                extra: SetGuestCustomerScreenArgs(initialCustomer: customer),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.l),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.neutralGray),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.person_outline,
                    color: AppColors.primaryNavy,
                  ),
                  const SizedBox(width: AppSpacing.m),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hasCustomer
                              ? '${customer.firstName} ${customer.lastName}'
                              : 'Set Customer Information',
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (hasCustomer) ...[
                          const SizedBox(height: 4),
                          Text(
                            customer.emailAddress,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
