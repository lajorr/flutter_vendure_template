import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vendure_flutter_app/app/router/app_routes.dart';
import 'package:vendure_flutter_app/core/extensions/cart_ext.dart';
import 'package:vendure_flutter_app/core/theme/app_colors.dart';
import 'package:vendure_flutter_app/core/theme/app_spacing.dart';
import 'package:vendure_flutter_app/core/theme/app_text_styles.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/active_order.dart';
import 'package:vendure_flutter_app/features/customer/presentation/screens/add_address_screen.dart';

class GuestAddressTile extends StatelessWidget {
  const GuestAddressTile({super.key, required this.address});

  final ActiveOrderAddress address;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryNavy, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: AppSpacing.s,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_on_outlined,
                  color: AppColors.primaryNavy,
                  size: 20,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.fullName?.capitalizeFirst ?? 'Guest Customer',
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${address.streetLine1?.capitalizeFirst ?? ''}${address.streetLine2 != null ? ', ${address.streetLine2?.capitalizeFirst}' : ''}',
                      style: AppTextStyles.bodyLarge,
                    ),
                    Text(
                      '${address.city?.capitalizeFirst ?? ''}, ${address.province?.capitalizeFirst ?? ''} ${address.postalCode ?? ''}',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (address.phoneNumber != null &&
                        address.phoneNumber!.isNotEmpty) ...[
                      AppSpacing.vXXS,
                      Text(
                        address.phoneNumber!,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  context.pushNamed(
                    AppRoute.addAddress.name,
                    extra: AddAddressScreenArgs(
                      isGuest: true,
                      initialAddress: address,
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Change',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primaryNavy,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
