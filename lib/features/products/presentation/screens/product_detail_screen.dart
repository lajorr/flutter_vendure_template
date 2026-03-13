import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/controllers/products_controller.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class ProductDetailScreen extends ConsumerWidget {
  final String slug;

  const ProductDetailScreen({super.key, required this.slug});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productDetailsProvider(slug));

    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: productState.when(
        data: (product) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (product.imageUrl.isNotEmpty)
                  Image.network(
                    product.imageUrl,
                    height: 300,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(
                          height: 300,
                          child: Icon(Icons.error, size: 50),
                        ),
                  )
                else
                  const SizedBox(
                    height: 300,
                    child: Center(child: Icon(Icons.image_not_supported, size: 50)),
                  ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.m),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: AppTextStyles.h1,
                      ),
                      AppSpacing.vXS,
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: AppTextStyles.h2.copyWith(
                          color: AppColors.primaryNavy,
                        ),
                      ),
                      AppSpacing.vL,
                      Text(
                        'Description',
                        style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                      ),
                      AppSpacing.vXS,
                      Text(
                        product.description,
                        style: AppTextStyles.bodyLarge,
                      ),
                      AppSpacing.vXL,
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Add to cart functionality
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Added to cart!')),
                            );
                          },
                          icon: const Icon(Icons.add_shopping_cart),
                          label: const Text('Add to Cart'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
