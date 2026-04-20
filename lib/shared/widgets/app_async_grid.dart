import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendure_flutter_app/core/theme/app_colors.dart';
import 'package:vendure_flutter_app/core/theme/app_spacing.dart';
import 'package:vendure_flutter_app/core/theme/app_text_styles.dart';
import 'package:vendure_flutter_app/features/products/presentation/widgets/product_card_shimmer.dart';

class AppAsyncGrid<T> extends StatefulWidget {
  const AppAsyncGrid({
    super.key,
    required this.state,
    required this.itemBuilder,
    this.onLoadMore,
    this.onRefresh, // null = sliver mode, non-null = standalone
    this.isLoadingMore = false,
    this.loadingPlaceholder,
    this.childAspectRatio = 0.7,
    this.shimmerCount = 4,
    this.crossAxisCount = 2,
    this.padding = const EdgeInsets.symmetric(horizontal: AppSpacing.m),
    this.sectionTitle,
    this.onViewAll,
    this.visibleCount,
  });

  final AsyncValue<List<T>> state;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final VoidCallback? onLoadMore;
  final Future<void> Function()? onRefresh;
  final bool isLoadingMore;
  final Widget? loadingPlaceholder;
  final double childAspectRatio;
  final int shimmerCount;
  final int crossAxisCount;
  final EdgeInsets padding;
  final String? sectionTitle;
  final VoidCallback? onViewAll;
  final int? visibleCount;

  @override
  State<AppAsyncGrid<T>> createState() => _AppAsyncGridState<T>();
}

class _AppAsyncGridState<T> extends State<AppAsyncGrid<T>> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (widget.onLoadMore == null) return;
    if (widget.isLoadingMore) return;

    final position = _scrollController.position;
    final threshold = position.maxScrollExtent * 0.8;

    if (position.pixels >= threshold) {
      widget.onLoadMore!();
    }
  }

  SliverGrid _buildSliverGrid(List<T> items) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        childAspectRatio: widget.childAspectRatio,
        crossAxisSpacing: AppSpacing.m,
        mainAxisSpacing: AppSpacing.m,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        return widget.itemBuilder(context, items[index]);
      }, childCount: items.length),
    );
  }

  Widget _buildShimmerGrid() {
    return SliverPadding(
      padding: widget.padding,
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount,
          childAspectRatio: widget.childAspectRatio,
          crossAxisSpacing: AppSpacing.m,
          mainAxisSpacing: AppSpacing.m,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) =>
              widget.loadingPlaceholder ?? const ProductCardShimmer(),
          childCount: widget.shimmerCount,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.state.when(
      loading: () => _buildShimmerGrid(),
      error: (e, _) => const SliverToBoxAdapter(
        child: Center(child: Text('Error loading items')),
      ),
      data: (items) {
        final sliverContent = SliverPadding(
          padding: widget.padding,
          sliver: _buildSliverGrid(items),
        );

        final sectionHeader = widget.sectionTitle == null
            ? null
            : SliverToBoxAdapter(
                child: Padding(
                  padding: widget.padding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.sectionTitle!, style: AppTextStyles.h2),
                      if (widget.onViewAll != null &&
                          items.length > (widget.visibleCount ?? 0))
                        TextButton(
                          onPressed: widget.onViewAll,
                          child: Text(
                            'View all',
                            style: TextStyle(color: AppColors.primaryNavy),
                          ),
                        ),
                    ],
                  ),
                ),
              );

        // Sliver mode — caller owns the scroll view
        if (widget.onRefresh == null) {
          return SliverMainAxisGroup(
            slivers: [
              ?sectionHeader,
              SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xs)),
              sliverContent,
              if (widget.isLoadingMore)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          );
        }

        // Standalone mode — owns its own scroll + refresh
        return RefreshIndicator(
          onRefresh: widget.onRefresh!,
          child: CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              ?sectionHeader,
              sliverContent,
              if (widget.isLoadingMore)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
