import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendure_flutter_app/core/extensions/cart_ext.dart';
import 'package:vendure_flutter_app/core/theme/app_colors.dart';
import 'package:vendure_flutter_app/core/theme/app_spacing.dart';
import 'package:vendure_flutter_app/core/theme/app_text_styles.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_item_controller.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_item_state.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/cart_item_data.dart';
import 'package:vendure_flutter_app/shared/widgets/app_cached_network_image.dart';

class CartItemsSection extends StatelessWidget {
  const CartItemsSection({super.key, required this.items});

  final List<CartItemData> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map((item) => _CartItemCard(key: ValueKey(item.id), item: item))
          .toList(),
    );
  }
}

class _CartItemCard extends ConsumerWidget {
  const _CartItemCard({super.key, required this.item});

  final CartItemData item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItemState = ref.watch(cartItemControllerProvider);
    final isThisItemLoading = cartItemState.maybeWhen(
      loading: (_, orderLineId) => orderLineId == item.id,
      orElse: () => false,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.s),
      padding: const EdgeInsets.all(AppSpacing.m),
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
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
                child: SizedBox(
                  width: 96,
                  height: 96,
                  child: AppCachedNetworkImage(
                    imageUrl: item.imageUrl,
                    width: 96,
                    height: 96,
                  ),
                ),
              ),
              AppSpacing.hM,
              Expanded(
                child: SizedBox(
                  height: 96,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.name,
                              style: AppTextStyles.bodyLarge.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            item.price.formattedPrice,
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.primaryNavy,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        'Variant: ${item.variantLabel}',
                        style: AppTextStyles.bodySmall,
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _QuantitySelector(item: item),
                          TextButton.icon(
                            onPressed: isThisItemLoading
                                ? null
                                : () {
                                    ref
                                        .read(
                                          cartItemControllerProvider.notifier,
                                        )
                                        .removeOrderLine(orderLineId: item.id);
                                  },
                            icon: const Icon(
                              Icons.delete_outline,
                              size: 18,
                              color: AppColors.textSecondary,
                            ),
                            label: const Text(
                              'Remove',
                              style: AppTextStyles.bodySmall,
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.textSecondary,
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (isThisItemLoading)
            Positioned.fill(
              child: Container(
                color: Colors.white.withValues(alpha: 0.5),
                child: const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _QuantitySelector extends ConsumerWidget {
  const _QuantitySelector({required this.item});

  final CartItemData item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItemState = ref.watch(cartItemControllerProvider);
    final isThisItemLoading = cartItemState.maybeWhen(
      loading: (_, orderLineId) => orderLineId == item.id,
      orElse: () => false,
    );

    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.neutralGray,
        borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: (isThisItemLoading || item.quantity <= 1)
                ? null
                : () {
                    ref
                        .read(cartItemControllerProvider.notifier)
                        .adjustLineQuantity(
                          orderLineId: item.id,
                          quantity: item.quantity - 1,
                        );
                  },
            icon: const Icon(Icons.remove, size: 16),
            splashRadius: 16,
            visualDensity: VisualDensity.compact,
          ),
          SizedBox(
            width: 28,
            child: Text(
              '${item.quantity}',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            onPressed: isThisItemLoading
                ? null
                : () {
                    ref
                        .read(cartItemControllerProvider.notifier)
                        .adjustLineQuantity(
                          orderLineId: item.id,
                          quantity: item.quantity + 1,
                        );
                  },
            icon: const Icon(Icons.add, size: 16),
            splashRadius: 16,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
