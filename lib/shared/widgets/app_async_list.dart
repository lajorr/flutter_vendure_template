import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendure_flutter_app/core/theme/app_colors.dart';
import 'package:vendure_flutter_app/core/theme/app_spacing.dart';
import 'package:vendure_flutter_app/core/theme/app_text_styles.dart';
import 'package:vendure_flutter_app/features/products/presentation/widgets/product_card_shimmer.dart';

class AppAsyncList<T> extends StatelessWidget {
  const AppAsyncList({
    super.key,
    required this.state,
    required this.itemBuilder,
    this.sectionTitle,
    this.onLoadMore,
    this.onRefresh,
    this.isLoadingMore = false,
    this.loadingPlaceholder,
    this.shimmerCount = 4,
    this.itemWidth = 160,
    this.itemHeight = 220,
    this.padding = const EdgeInsets.symmetric(horizontal: AppSpacing.m),
    this.itemSpacing = AppSpacing.m,
    this.onViewAll,
    this.visibleCount,
  });

  final AsyncValue<List<T>> state;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final String? sectionTitle;
  final VoidCallback? onLoadMore;
  final Future<void> Function()? onRefresh;
  final bool isLoadingMore;
  final Widget? loadingPlaceholder;
  final int shimmerCount;
  final double itemWidth;
  final double itemHeight;
  final EdgeInsets padding;
  final double itemSpacing;
  final VoidCallback? onViewAll;
  final int? visibleCount;

  Widget _buildShimmer() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: itemHeight,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: padding,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: shimmerCount,
          separatorBuilder: (_, _) => SizedBox(width: itemSpacing),
          itemBuilder: (_, _) => SizedBox(
            width: itemWidth,
            child: loadingPlaceholder ?? const ProductCardShimmer(),
          ),
        ),
      ),
    );
  }

  Widget _buildList(List<T> items) {
    return SizedBox(
      height: itemHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: padding,
        itemCount: isLoadingMore ? items.length + 1 : items.length,
        separatorBuilder: (_, _) => SizedBox(width: itemSpacing),
        itemBuilder: (context, index) {
          if (index == items.length - 1) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => onLoadMore?.call(),
            );
          }
          if (index == items.length) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.m),
                child: const CircularProgressIndicator(),
              ),
            );
          }
          return SizedBox(
            width: itemWidth,
            child: itemBuilder(context, items[index]),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return state.when(
      loading: () => SliverMainAxisGroup(
        slivers: [
          if (sectionTitle != null)
            SliverToBoxAdapter(child: Text(sectionTitle!)),
          _buildShimmer(),
        ],
      ),
      error: (e, _) => const SliverToBoxAdapter(
        child: Center(child: Text('Error loading items')),
      ),
      data: (items) {
        final sectionHeader = sectionTitle == null
            ? null
            : SliverToBoxAdapter(
                child: Padding(
                  padding: padding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(sectionTitle!, style: AppTextStyles.h2),
                      if (onViewAll != null &&
                          items.length > (visibleCount ?? 0))
                        TextButton(
                          onPressed: onViewAll,
                          child: Text(
                            'View all',
                            style: TextStyle(color: AppColors.primaryNavy),
                          ),
                        ),
                    ],
                  ),
                ),
              );
        final slivers = [
          ?sectionHeader,
          SliverToBoxAdapter(child: _buildList(items)),
        ];

        if (onRefresh == null) {
          return SliverMainAxisGroup(slivers: slivers);
        }

        return RefreshIndicator(
          onRefresh: onRefresh!,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: slivers,
          ),
        );
      },
    );
  }
}
