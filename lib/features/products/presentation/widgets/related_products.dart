import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vendure_flutter_app/app/router/app_routes.dart';
import 'package:vendure_flutter_app/core/theme/app_colors.dart';
import 'package:vendure_flutter_app/core/theme/app_spacing.dart';
import 'package:vendure_flutter_app/core/theme/app_text_styles.dart';
import 'package:vendure_flutter_app/features/products/domain/entities/product.dart';
import 'package:vendure_flutter_app/shared/widgets/app_cached_network_image.dart';

class RelatedProducts extends StatelessWidget {
  const RelatedProducts({
    super.key,
    required this.currentProductId,
    required this.productsState,
  });

  final String currentProductId;
  final AsyncValue<List<Product>> productsState;

  @override
  Widget build(BuildContext context) {
    return productsState.when(
      data: (products) {
        final related = products
            .where((item) => item.id != currentProductId)
            .take(3)
            .toList();

        if (related.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You May Also Like',
              style: AppTextStyles.label.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
            AppSpacing.vM,
            SizedBox(
              height: 220,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: related.length,
                separatorBuilder: (_, _) => AppSpacing.hS,
                itemBuilder: (context, index) {
                  final product = related[index];
                  final imageUrl = product.assets.isNotEmpty
                      ? product.assets.first.source
                      : '';
                  return GestureDetector(
                    onTap: () => context.pushNamed(
                      AppRoute.productDetail.name,
                      pathParameters: {'id': product.id},
                    ),
                    child: SizedBox(
                      width: 160,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: imageUrl.isNotEmpty
                                  ? AppCachedNetworkImage(
                                      imageUrl: imageUrl,
                                      height: double.infinity,
                                      width: double.infinity,
                                    )
                                  : Container(
                                      color: AppColors.neutralGray,
                                      child: const Icon(
                                        Icons.image_not_supported,
                                      ),
                                    ),
                            ),
                          ),
                          AppSpacing.vXS,
                          Text(
                            product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          AppSpacing.vXXS,
                          Text(
                            product.getFirstVariant.formattedPrice,
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.primaryNavy,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}
