import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/controllers/products_controller.dart';
import '../../../../shared/widgets/common_grid_view.dart';
import '../widgets/product_card.dart';
import '../widgets/product_card_shimmer.dart';

import '../../../../core/theme/app_spacing.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(productsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendure Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => context.pushNamed('cart'),
          ),
        ],
      ),
      body: productsState.when(
        skipLoadingOnReload: true,
        skipLoadingOnRefresh: true,
        data: (products) {
          if (products.isEmpty && !productsState.isLoading) {
            return const Center(child: Text('No products available.'));
          }

          return CommonGridView(
            items: products,
            isLoadingMore: productsState.isLoading && products.isNotEmpty,
            onRefresh: () =>
                ref.read(productsControllerProvider.notifier).refresh(),
            onLoadMore: () =>
                ref.read(productsControllerProvider.notifier).loadMore(),
            itemBuilder: (context, product) {
              return ProductCard(
                product: product,
                onTap: () {
                  context.goNamed(
                    'product_detail',
                    pathParameters: {'slug': product.slug},
                  );
                },
              );
            },
          );
        },
        loading: () => GridView.builder(
          padding: const EdgeInsets.all(AppSpacing.m),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: AppSpacing.m,
            mainAxisSpacing: AppSpacing.m,
          ),
          itemCount: 6,
          itemBuilder: (context, index) => const ProductCardShimmer(),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $error'),
              AppSpacing.vM,
              ElevatedButton(
                onPressed: () =>
                    ref.read(productsControllerProvider.notifier).refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
