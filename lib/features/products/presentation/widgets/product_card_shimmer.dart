import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/common_shimmer.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: ShimmerPlaceholder(
              borderRadius: AppSpacing.radiusCard,
            ),
          ),
          AppSpacing.vXS,
          const ShimmerPlaceholder(width: 60, height: 10),
          AppSpacing.vXXS,
          const ShimmerPlaceholder(width: 120, height: 16),
          AppSpacing.vXXS,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ShimmerPlaceholder(width: 50, height: 18),
              ShimmerPlaceholder(
                width: 28,
                height: 28,
                borderRadius: 8,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
