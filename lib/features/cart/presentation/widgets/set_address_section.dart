import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vendure_flutter_app/app/router/app_routes.dart';
import 'package:vendure_flutter_app/core/theme/app_colors.dart';
import 'package:vendure_flutter_app/core/theme/app_spacing.dart';
import 'package:vendure_flutter_app/core/theme/app_text_styles.dart';
import 'package:vendure_flutter_app/features/cart/application/providers/cart_providers.dart';
import 'package:vendure_flutter_app/features/cart/presentation/widgets/guest_address_tile.dart';
import 'package:vendure_flutter_app/features/customer/presentation/screens/add_address_screen.dart';
import 'package:vendure_flutter_app/shared/widgets/custom_container.dart';

class SetAddressSection extends ConsumerWidget {
  const SetAddressSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shippingAddress = ref.watch(shippingAddressProvider);

    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Deliver to', style: AppTextStyles.h3),
          AppSpacing.vM,
          if (shippingAddress != null && !shippingAddress.isEmpty)
            GuestAddressTile(address: shippingAddress)
          else
            InkWell(
              onTap: () {
                context.pushNamed(
                  AppRoute.addAddress.name,
                  extra: AddAddressScreenArgs(isGuest: true),
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
                      Icons.location_on_outlined,
                      color: AppColors.primaryNavy,
                    ),
                    const SizedBox(width: AppSpacing.m),
                    Expanded(
                      child: Text(
                        'Set shipping address',
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
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
