import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendure_flutter_app/app/router/app_routes.dart';
import 'package:vendure_flutter_app/core/theme/app_colors.dart';
import 'package:vendure_flutter_app/core/theme/app_spacing.dart';
import 'package:vendure_flutter_app/core/theme/app_text_styles.dart';
import 'package:vendure_flutter_app/features/dashboard/application/dashboard_controller.dart';

class CartEmptyView extends ConsumerWidget {
  const CartEmptyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.neutralGray,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 48,
                color: AppColors.textSecondary,
              ),
            ),
            AppSpacing.vL,
            Text(
              'Your cart is empty',
              style: AppTextStyles.h1,
              textAlign: TextAlign.center,
            ),
            AppSpacing.vXS,
            Text(
              'Looks like you haven\'t added\nanything to your cart yet.',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.vL,
            FilledButton.icon(
              onPressed: () {
                ref
                    .read(dashboardControllerProvider.notifier)
                    .setIndex(DashboardTabs.home);
              },
              icon: const Icon(Icons.storefront_outlined),
              label: const Text('Continue Shopping'),
            ),
          ],
        ),
      ),
    );
  }
}
