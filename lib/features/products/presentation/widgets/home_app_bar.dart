import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendure_flutter_app/app/router/app_routes.dart';
import 'package:vendure_flutter_app/core/theme/app_colors.dart';
import 'package:vendure_flutter_app/core/theme/app_spacing.dart';
import 'package:vendure_flutter_app/core/theme/app_text_styles.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_controller.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_state.dart';
import 'package:vendure_flutter_app/features/dashboard/application/dashboard_controller.dart';

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartControllerProvider);
    final totalQuantity = cartState.maybeWhen(
      success: (activeOrder) => activeOrder?.totalQuantity ?? 0,
      orElse: () => 0,
    );

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.m),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.shopping_bag, color: AppColors.primaryNavy),
                AppSpacing.hXS,
                Text(
                  'Vendure',
                  style: AppTextStyles.h2.copyWith(
                    color: AppColors.primaryNavy,
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () => ref
                      .read(dashboardControllerProvider.notifier)
                      .setIndex(DashboardTabs.cart),
                ),
                if (totalQuantity > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryNavy,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '$totalQuantity',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
