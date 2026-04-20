import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vendure_flutter_app/core/extensions/cart_ext.dart';
import 'package:vendure_flutter_app/core/theme/app_colors.dart';
import 'package:vendure_flutter_app/core/theme/app_spacing.dart';
import 'package:vendure_flutter_app/core/theme/app_text_styles.dart';
import 'package:vendure_flutter_app/features/products/domain/entities/product.dart';
import 'package:vendure_flutter_app/features/products/domain/entities/product_option.dart';
import 'package:vendure_flutter_app/features/products/domain/entities/product_option_group.dart';
import 'package:vendure_flutter_app/features/products/domain/entities/product_variant.dart';
import 'package:vendure_flutter_app/features/products/presentation/widgets/color_option.dart';
import 'package:vendure_flutter_app/features/products/presentation/widgets/image_carousel.dart';
import 'package:vendure_flutter_app/features/products/presentation/widgets/option_chip.dart';
import 'package:vendure_flutter_app/features/products/presentation/widgets/related_products.dart';

class ProductDetailContent extends StatelessWidget {
  const ProductDetailContent({
    super.key,
    required this.product,
    required this.productsState,
    required this.pageController,
    required this.currentImage,
    required this.selectedOptions,
    required this.onImageChanged,
    required this.onOptionSelected,
  });

  final Product product;
  final AsyncValue<List<Product>> productsState;
  final PageController pageController;
  final int currentImage;
  final Map<String, String> selectedOptions;
  final ValueChanged<int> onImageChanged;
  final void Function(ProductOptionGroup group, ProductOption option)
  onOptionSelected;

  @override
  Widget build(BuildContext context) {
    final selectedVariant = _findMatchingVariant(product, selectedOptions);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final images = product.assets.map((asset) => asset.source).toList();
    final optionGroups = product.optionGroups
        .where((group) => group.options.isNotEmpty)
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: AppSpacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageCarousel(
            imageUrls: images,
            pageController: pageController,
            currentIndex: currentImage,
            onPageChanged: onImageChanged,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.m,
              AppSpacing.l,
              AppSpacing.m,
              AppSpacing.m,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name, style: AppTextStyles.h1),
                          AppSpacing.vXS,
                          _StockTag(inStock: _isInStock(selectedVariant)),
                        ],
                      ),
                    ),
                    AppSpacing.hS,
                    Text(
                      selectedVariant.formattedPrice,
                      style: AppTextStyles.h1.copyWith(
                        color: AppColors.primaryNavy,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
                AppSpacing.vM,
                ...optionGroups.map((group) {
                  final isColorGroup = _isColorGroup(group);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.m),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionHeader(
                          title: group.name,
                          actionText: _isSizeGroup(group) ? 'Size Guide' : null,
                          onActionTap: _isSizeGroup(group)
                              ? () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Size guide coming soon'),
                                    ),
                                  );
                                }
                              : null,
                        ),
                        AppSpacing.vXS,
                        if (isColorGroup)
                          Wrap(
                            spacing: AppSpacing.s,
                            runSpacing: AppSpacing.s,
                            children: group.options.map((option) {
                              final selected =
                                  (selectedOptions[group.id] ??
                                      group.options.first.id) ==
                                  option.id;
                              return ColorOption(
                                color: _mapColor(option.name, isDark: isDark),
                                selected: selected,
                                onTap: () => onOptionSelected(group, option),
                              );
                            }).toList(),
                          )
                        else
                          Wrap(
                            spacing: AppSpacing.s,
                            runSpacing: AppSpacing.s,
                            children: group.options.map((option) {
                              final selected =
                                  (selectedOptions[group.id] ??
                                      group.options.first.id) ==
                                  option.id;

                              return OptionChip(
                                label: option.name,
                                selected: selected,
                                onTap: () => onOptionSelected(group, option),
                              );
                            }).toList(),
                          ),
                      ],
                    ),
                  );
                }),
                Container(
                  padding: const EdgeInsets.only(top: AppSpacing.l),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.black.withValues(alpha: 0.06),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: AppTextStyles.label.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                          color: isDark ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                      AppSpacing.vS,
                      Text(
                        _cleanDescription(product.description),
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.7)
                              : AppColors.textSecondary,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpacing.vXL,
                RelatedProducts(
                  currentProductId: product.id,
                  productsState: productsState,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _isSizeGroup(ProductOptionGroup group) {
    final name = group.name.toLowerCase();
    final code = group.code?.toLowerCase() ?? '';
    return name.contains('size') || code.contains('size');
  }

  bool _isColorGroup(ProductOptionGroup group) {
    final name = group.name.toLowerCase();
    final code = group.code?.toLowerCase() ?? '';
    return name.contains('color') || code.contains('color');
  }

  ProductVariant? _findMatchingVariant(
    Product product,
    Map<String, String> selectedOptions,
  ) {
    if (product.variants.isEmpty) return null;
    if (selectedOptions.isEmpty) return product.variants.first;

    for (final variant in product.variants) {
      final optionIds = variant.optionValues.map((value) => value.id).toSet();
      final matches = selectedOptions.values.every(optionIds.contains);
      if (matches) return variant;
    }
    return product.variants.first;
  }

  bool _isInStock(ProductVariant? variant) {
    final stockLevel = variant?.stockLevel?.toLowerCase();
    if (stockLevel == null || stockLevel.isEmpty) return true;
    return stockLevel.contains('in');
  }

  String _cleanDescription(String? description) {
    if (description == null || description.trim().isEmpty) {
      return 'Comfortable everyday essential crafted with quality materials and designed for long-lasting wear.';
    }
    return description
        .replaceAll(RegExp(r'<[^>]*>'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  Color _mapColor(String colorName, {required bool isDark}) {
    final normalized = colorName.toLowerCase();
    if (normalized.contains('white')) return Colors.white;
    if (normalized.contains('black')) return Colors.black;
    if (normalized.contains('blue')) return Colors.blue.shade600;
    if (normalized.contains('red')) return Colors.red.shade500;
    if (normalized.contains('green')) return Colors.green.shade500;
    if (normalized.contains('grey') || normalized.contains('gray')) {
      return Colors.grey.shade400;
    }
    if (normalized.contains('beige') || normalized.contains('stone')) {
      return const Color(0xFFA8A29E);
    }
    return isDark ? Colors.grey.shade300 : Colors.grey.shade600;
  }
}

class _StockTag extends StatelessWidget {
  const _StockTag({required this.inStock});

  final bool inStock;

  @override
  Widget build(BuildContext context) {
    final color = inStock ? AppColors.successGreen : Colors.red.shade500;
    final text = inStock ? 'In Stock' : 'Out of Stock';

    return Row(
      children: [
        Icon(Icons.check_circle, size: 14, color: color),
        AppSpacing.hXXS,
        Text(
          text,
          style: AppTextStyles.bodySmall.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    this.actionText,
    this.onActionTap,
  });

  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title.capitalizeFirstLetterOfEachWord,
          style: AppTextStyles.label.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
            color: isDark ? Colors.white : AppColors.textPrimary,
          ),
        ),
        // if (actionText != null)
        //   TextButton(
        //     onPressed: onActionTap,
        //     style: TextButton.styleFrom(padding: EdgeInsets.zero),
        //     child: Text(
        //       actionText!,
        //       style: AppTextStyles.label.copyWith(
        //         color: AppColors.primaryNavy,
        //         decoration: TextDecoration.underline,
        //         fontWeight: FontWeight.w600,
        //       ),
        //     ),
        //   ),
      ],
    );
  }
}
