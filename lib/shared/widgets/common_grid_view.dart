import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';

class CommonGridView<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final bool isLoadingMore;
  final VoidCallback onLoadMore;
  final Future<void> Function()? onRefresh; // null = sliver mode
  final int crossAxisCount;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final EdgeInsetsGeometry padding;

  const CommonGridView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.isLoadingMore = false,
    required this.onLoadMore,
    this.onRefresh,
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.7,
    this.crossAxisSpacing = AppSpacing.m,
    this.mainAxisSpacing = AppSpacing.m,
    this.padding = const EdgeInsets.all(AppSpacing.m),
  });

  SliverGrid _buildSliverGrid(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == items.length - 1) {
            WidgetsBinding.instance.addPostFrameCallback((_) => onLoadMore());
          }
          return itemBuilder(context, items[index]);
        },
        childCount: items.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Sliver mode — caller owns the scroll view
    if (onRefresh == null) {
      return SliverPadding(
        padding: padding,
        sliver: _buildSliverGrid(context),
      );
    }

    // Standalone mode — owns its own scroll view + refresh
    return RefreshIndicator(
      onRefresh: onRefresh!,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: padding,
            sliver: _buildSliverGrid(context),
          ),
          if (isLoadingMore)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }
}