import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vendure_flutter_app/app/router/app_routes.dart';
import 'package:vendure_flutter_app/core/theme/app_colors.dart';
import 'package:vendure_flutter_app/core/theme/app_spacing.dart';
import 'package:vendure_flutter_app/core/theme/app_text_styles.dart';
import 'package:vendure_flutter_app/features/customer/application/controllers/customer_addresses_controller.dart';
import 'package:vendure_flutter_app/features/customer/application/controllers/customer_addresses_state.dart';

class AddressSelectionSection extends ConsumerStatefulWidget {
  const AddressSelectionSection({super.key});

  @override
  ConsumerState<AddressSelectionSection> createState() =>
      _AddressSelectionSectionState();
}

class _AddressSelectionSectionState
    extends ConsumerState<AddressSelectionSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(customerAddressesControllerProvider.notifier)
          .fetchCustomerAddresses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final addressState = ref.watch(customerAddressesControllerProvider);

    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.m,
        AppSpacing.xxs,
        AppSpacing.m,
        AppSpacing.s,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(color: AppColors.neutralGray),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Deliver to', style: AppTextStyles.h3),
              TextButton.icon(
                onPressed: () {
                  context.pushNamed(AppRoute.addAddress.name);
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add New'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primaryNavy,
                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          addressState.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(child: Text(message)),
            success: (addresses, selectedAddress) {
              if (addresses.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.l),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'No addresses found',
                          style: AppTextStyles.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Column(
                children: List.generate(addresses.length, (index) {
                  final address = addresses[index];
                  final isSelected = selectedAddress?.id == address.id;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.m),
                    child: InkWell(
                      onTap: () {
                        ref
                            .read(customerAddressesControllerProvider.notifier)
                            .selectAddress(address);
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.l),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryLight.withValues(alpha: 0.3)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryNavy
                                : AppColors.neutralGray,
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: isSelected
                              ? []
                              : [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.02),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              right: 0,
                              child: const Text(
                                'Edit',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryNavy,
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  margin: const EdgeInsets.only(top: 2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primaryNavy
                                          : AppColors.textSecondary.withValues(
                                              alpha: 0.5,
                                            ),
                                      width: 2,
                                    ),
                                  ),
                                  child: isSelected
                                      ? Center(
                                          child: Container(
                                            width: 12,
                                            height: 12,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.primaryNavy,
                                            ),
                                          ),
                                        )
                                      : null,
                                ),
                                const SizedBox(width: AppSpacing.m),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        address.defaultShippingAddress
                                            ? 'Default Address'
                                            : 'Address',
                                        style: AppTextStyles.bodyLarge.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      AppSpacing.hXS,
                                      if (address.fullName != null &&
                                          address.fullName!.isNotEmpty)
                                        Text(
                                          address.fullName!,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.textSecondary
                                                .withValues(alpha: 0.8),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      if (address.fullName != null &&
                                          address.fullName!.isNotEmpty)
                                        AppSpacing.hXXS,
                                      if (address.phoneNumber != null &&
                                          address.phoneNumber!.isNotEmpty)
                                        Text(
                                          address.phoneNumber!,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.textSecondary
                                                .withValues(alpha: 0.8),
                                          ),
                                        ),
                                      if (address.phoneNumber != null &&
                                          address.phoneNumber!.isNotEmpty)
                                        AppSpacing.hM,
                                      if (address.streetLine1 != null &&
                                          address.streetLine1!.isNotEmpty)
                                        Text(
                                          address.streetLine1!,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      if (address.streetLine2 != null &&
                                          address.streetLine2!.isNotEmpty) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          address.streetLine2!,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      ],
                                      AppSpacing.hXXS,
                                      Text(
                                        '${address.city ?? ''}, ${address.province ?? ''} ${address.postalCode ?? ''}',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 32,
                                ), // Space for the Edit button stack
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
