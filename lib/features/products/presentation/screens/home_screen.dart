import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vendure_flutter_app/shared/widgets/common_grid_view.dart';
import 'package:vendure_flutter_app/shared/widgets/common_shimmer.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../collections/application/providers/collection_providers.dart';
import '../../../dashboard/application/dashboard_controller.dart';
import '../../application/controllers/products_controller.dart';
import '../../domain/entities/product.dart';
import '../widgets/product_card.dart';
import '../widgets/product_card_shimmer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(collectionsListProvider);
            await ref.read(productsControllerProvider.notifier).refresh();
          },
          child: CustomScrollView(
            slivers: [
              const _HomeAppBar(),
              const _SearchBar(),
              const _PromoBanner(),
              const _CollectionSection(),
              const _FeaturedProductsHeader(),
              const _FeaturedProductsGrid(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeAppBar extends ConsumerWidget {
  const _HomeAppBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    child: const Text(
                      '0',
                      style: TextStyle(color: Colors.white, fontSize: 10),
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

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search for products',
            prefixIcon: const Icon(
              Icons.search,
              color: AppColors.textSecondary,
            ),
            filled: true,
            fillColor: AppColors.neutralGray,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusInput),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}

class _PromoBanner extends StatelessWidget {
  const _PromoBanner();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.m),
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
            image: const DecorationImage(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1445205170230-053b83016050?q=80&w=1000&auto=format&fit=crop',
              ), // Placeholder, would ideally use generate_image if needed
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class _CollectionSection extends ConsumerWidget {
  const _CollectionSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectionsAsync = ref.watch(collectionsListProvider);

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Shop by Collection', style: AppTextStyles.h2),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View all',
                    style: TextStyle(color: AppColors.primaryNavy),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 110,
            child: collectionsAsync.when(
              data: (collections) => ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
                scrollDirection: Axis.horizontal,
                itemCount: collections.length,
                separatorBuilder: (context, index) => AppSpacing.hM,
                itemBuilder: (context, index) {
                  final collection = collections[index];
                  return InkWell(
                    onTap: () => context.pushReplacementNamed(
                      AppRoute.products.name,
                      queryParameters: {'collection': collection.slug},
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: AppColors.neutralGray,
                          backgroundImage:
                              collection.imageUrl != null &&
                                  collection.imageUrl!.isNotEmpty
                              ? NetworkImage(collection.imageUrl!)
                              : null,
                          child:
                              collection.imageUrl == null ||
                                  collection.imageUrl!.isEmpty
                              ? const Icon(
                                  Icons.category,
                                  color: AppColors.textSecondary,
                                )
                              : null,
                        ),
                        AppSpacing.vXS,
                        Text(
                          collection.name,
                          style: AppTextStyles.bodySmall.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              loading: () => ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (context, index) => AppSpacing.hM,
                itemBuilder: (context, index) => CommonShimmer(
                  child: Column(
                    children: [
                      const ShimmerPlaceholder(
                        width: 70,
                        height: 70,
                        borderRadius: 35,
                      ),
                      AppSpacing.vXS,
                      const ShimmerPlaceholder(width: 50, height: 10),
                    ],
                  ),
                ),
              ),
              error: (e, _) => Center(child: Text('Error loading collections')),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedProductsHeader extends StatelessWidget {
  const _FeaturedProductsHeader();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.m),
        child: Text('Featured Products', style: AppTextStyles.h2),
      ),
    );
  }
}

class _FeaturedProductsGrid extends ConsumerWidget {
  const _FeaturedProductsGrid();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(productsControllerProvider);

    return productsState.when(
      data: (products) {
        // final displayProducts = products.take(4).toList();
        return CommonGridView<Product>(
          items: products,
          itemBuilder: (context, product) => ProductCard(
            product: product,
            onTap: () => context.pushNamed(
              AppRoute.productDetail.name,
              pathParameters: {'id': product.id},
            ),
          ),
          onLoadMore:
              () {}, // No pagination needed here as it's a featured list
          childAspectRatio: 0.65,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
        );
      },
      loading: () => SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: AppSpacing.m,
            mainAxisSpacing: AppSpacing.m,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) => const ProductCardShimmer(),
            childCount: 4,
          ),
        ),
      ),
      error: (e, _) => const SliverToBoxAdapter(
        child: Center(child: Text('Error loading products')),
      ),
    );
  }
}
