import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_item_controller.dart';
import 'package:vendure_flutter_app/features/products/domain/entities/product.dart';
import 'package:vendure_flutter_app/features/products/domain/entities/product_variant.dart';
import 'package:vendure_flutter_app/features/products/presentation/widgets/product_detail_content.dart';
import 'package:vendure_flutter_app/features/products/presentation/widgets/sticky_footer.dart';

import '../../../cart/application/controllers/cart_item_state.dart';
import '../../application/controllers/products_controller.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final String id;

  const ProductDetailScreen({super.key, required this.id});

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  final PageController _pageController = PageController();
  final ValueNotifier<Map<String, String>> _selectedOptionsNotifier =
      ValueNotifier({});
  final ValueNotifier<int> _currentImageNotifier = ValueNotifier(0);

  @override
  void dispose() {
    _pageController.dispose();
    _selectedOptionsNotifier.dispose();
    _currentImageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productDetailsProvider(widget.id));
    final productsState = ref.watch(productsControllerProvider);
    final theme = Theme.of(context);
    final backgroundColor = theme.brightness == Brightness.dark
        ? const Color(0xFF131220)
        : const Color(0xFFF6F6F8);

    final cartItemState = ref.watch(cartItemControllerProvider);

    ref.listen(cartItemControllerProvider, (previous, next) {
      next.maybeWhen(
        success: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Added to cart successfully'),
              backgroundColor: Colors.green,
            ),
          );
        },
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.red),
          );
        },
        orElse: () {},
      );
    });

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Product Details'),
        centerTitle: true,
        backgroundColor: theme.colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Share coming soon')),
              );
            },
            icon: const Icon(Icons.share_outlined),
          ),
        ],
      ),
      body: productState.when(
        data: (product) => ValueListenableBuilder<int>(
          valueListenable: _currentImageNotifier,
          builder: (context, currentImage, _) {
            return ValueListenableBuilder<Map<String, String>>(
              valueListenable: _selectedOptionsNotifier,
              builder: (context, selectedOptions, _) {
                return ProductDetailContent(
                  product: product,
                  productsState: productsState,
                  pageController: _pageController,
                  currentImage: currentImage,
                  selectedOptions: selectedOptions,
                  onImageChanged: (index) =>
                      _currentImageNotifier.value = index,
                  onOptionSelected: (group, option) {
                    _selectedOptionsNotifier.value = {
                      ..._selectedOptionsNotifier.value,
                      group.id: option.id,
                    };
                  },
                );
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      bottomNavigationBar: productState.maybeWhen(
        data: (product) => ValueListenableBuilder<Map<String, String>>(
          valueListenable: _selectedOptionsNotifier,
          builder: (context, selectedOptions, _) {
            final selectedVariant = _findMatchingVariant(
              product,
              selectedOptions,
            );
            return StickyFooter(
              onAddToCart: () {
                if (selectedVariant != null) {
                  ref
                      .read(cartItemControllerProvider.notifier)
                      .addItemToOrder(
                        variantId: selectedVariant.id,
                        quantity: 1,
                      );
                }
              },
              inStock: _isInStock(selectedVariant),
              isLoading: cartItemState.maybeWhen(
                loading: (variantId, _) => variantId == selectedVariant?.id,
                orElse: () => false,
              ),
            );
          },
        ),
        orElse: () => null,
      ),
    );
  }

  ProductVariant? _findMatchingVariant(
    Product product,
    Map<String, String> selectedOptions,
  ) {
    if (product.variants.isEmpty) return null;
    if (selectedOptions.isEmpty) return product.variants.first;

    for (final variant in product.variants) {
      final optionIds = variant.optionValues.map((value) => value.id).toSet();
      final hasAllSelected = selectedOptions.values.every(optionIds.contains);
      if (hasAllSelected) return variant;
    }
    return product.variants.first;
  }

  bool _isInStock(ProductVariant? variant) {
    final stockLevel = variant?.stockLevel?.toLowerCase();
    if (stockLevel == null || stockLevel.isEmpty) return true;
    return stockLevel.contains('in');
  }
}
