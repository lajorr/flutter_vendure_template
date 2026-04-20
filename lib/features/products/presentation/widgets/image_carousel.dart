import 'package:flutter/material.dart';
import 'package:vendure_flutter_app/core/theme/app_colors.dart';
import 'package:vendure_flutter_app/core/theme/app_spacing.dart';
import 'package:vendure_flutter_app/shared/widgets/app_cached_network_image.dart';

class ImageCarousel extends StatelessWidget {
  const ImageCarousel({
    super.key,
    required this.imageUrls,
    required this.pageController,
    required this.currentIndex,
    required this.onPageChanged,
  });

  final List<String> imageUrls;
  final PageController pageController;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) {
      return AspectRatio(
        aspectRatio: 4 / 5,
        child: Container(
          color: AppColors.neutralGray,
          alignment: Alignment.center,
          child: const Icon(Icons.image_not_supported, size: 36),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 4 / 5,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: imageUrls.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) => AppCachedNetworkImage(
              imageUrl: imageUrls[index],
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Positioned(
            bottom: AppSpacing.m,
            child: Row(
              children: List.generate(
                imageUrls.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: index == currentIndex
                        ? AppColors.primaryNavy
                        : AppColors.primaryNavy.withValues(alpha: 0.25),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
