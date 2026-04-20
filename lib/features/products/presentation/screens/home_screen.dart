import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vendure_flutter_app/features/collections/application/controllers/collection_controllers.dart';
import 'package:vendure_flutter_app/features/products/domain/entities/product.dart';
import 'package:vendure_flutter_app/features/products/presentation/widgets/home_app_bar.dart';
import 'package:vendure_flutter_app/features/products/presentation/widgets/product_card.dart';
import 'package:vendure_flutter_app/shared/widgets/app_async_grid.dart';
import 'package:vendure_flutter_app/shared/widgets/common_shimmer.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../application/controllers/products_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await ref.read(collectionControllersProvider.notifier).refresh();
            await ref.read(productsControllerProvider.notifier).refresh();
          },
          child: CustomScrollView(
            slivers: [
              const HomeAppBar(),
              const _SearchBar(),
              SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xs)),
              const _PromoBanner(),
              const _CollectionSection(),
              SliverToBoxAdapter(child: SizedBox(height: AppSpacing.m)),
              AppAsyncGrid<Product>(
                sectionTitle: 'Featured Products',
                state: ref.watch(productsControllerProvider),
                itemBuilder: (context, product) => ProductCard(
                  product: product,
                  onTap: () => context.pushNamed(
                    AppRoute.productDetail.name,
                    pathParameters: {'id': product.id},
                  ),
                ),
              ),
            ],
          ),
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
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
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
    final collectionsAsync = ref.watch(collectionControllersProvider);

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
            height: 100,
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
                              ? CachedNetworkImageProvider(collection.imageUrl!)
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
