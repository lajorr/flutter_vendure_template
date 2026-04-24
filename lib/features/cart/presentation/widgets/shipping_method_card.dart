import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendure_flutter_app/core/theme/app_colors.dart';
import 'package:vendure_flutter_app/core/theme/app_spacing.dart';
import 'package:vendure_flutter_app/core/theme/app_text_styles.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/shipping_methods_controller.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/shipping_methods_state.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/shipping_method.dart';

class ShippingMethodCard extends ConsumerStatefulWidget {
  const ShippingMethodCard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShippingMethodCardState();
}

class _ShippingMethodCardState extends ConsumerState<ShippingMethodCard> {
  @override
  Widget build(BuildContext context) {
    ref.listen(shippingMethodsControllerProvider, (previous, next) {
      next.maybeWhen(
        success: (methods, selected) {
          final isSetting = ref
              .read(shippingMethodsControllerProvider.notifier)
              .isSettingMethod;
          if (methods.isNotEmpty && selected == null && !isSetting) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ref
                  .read(shippingMethodsControllerProvider.notifier)
                  .setShippingMethod(methods.first);
            });
          }
        },
        orElse: () {},
      );
    });

    final state = ref.watch(shippingMethodsControllerProvider);

    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.m,
        AppSpacing.m,
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Select Shipping Method', style: AppTextStyles.h3),
          AppSpacing.vS,
          Flexible(
            child: state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (message) => Center(child: Text(message)),
              success: (methods, selected) {
                return _buildMethodList(methods, selected);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodList(
    List<ShippingMethod> methods,
    ShippingMethod? selected,
  ) {
    if (methods.isEmpty) {
      return Text(
        'No shipping methods available.',
        style: AppTextStyles.bodySmall,
      );
    }

    final isSettingMethod = ref
        .read(shippingMethodsControllerProvider.notifier)
        .isSettingMethod;

    return Opacity(
      opacity: isSettingMethod ? 0.5 : 1.0,
      child: IgnorePointer(
        ignoring: isSettingMethod,
        child: ListView.separated(
          itemCount: methods.length,
          shrinkWrap: true,
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppSpacing.m),
          itemBuilder: (context, index) {
            final method = methods[index];
            final isSelected = selected?.id == method.id;

            return InkWell(
              onTap: () {
                final notifier = ref.read(
                  shippingMethodsControllerProvider.notifier,
                );
                if (notifier.isSettingMethod || isSelected) {
                  return;
                }
                notifier.setShippingMethod(method);
              },
              borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.m),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryLight.withValues(alpha: 0.3)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryNavy
                        : AppColors.neutralGray.withValues(alpha: 0.5),
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
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        method.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${(method.priceWithTax / 100).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryNavy,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryNavy
                              : AppColors.neutralGray,
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
