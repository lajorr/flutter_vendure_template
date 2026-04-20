import 'package:flutter/material.dart';
import 'package:vendure_flutter_app/core/theme/app_colors.dart';

class ColorOption extends StatelessWidget {
  const ColorOption({
    super.key,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: color == Colors.white
                ? (isDark ? Colors.white54 : const Color(0xFFE5E7EB))
                : Colors.transparent,
          ),
          boxShadow: [
            if (selected)
              BoxShadow(
                color: AppColors.primaryNavy.withValues(alpha: 0.25),
                blurRadius: 0,
                spreadRadius: 3,
              ),
          ],
        ),
      ),
    );
  }
}
