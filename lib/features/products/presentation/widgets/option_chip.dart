import 'package:flutter/material.dart';
import 'package:vendure_flutter_app/core/theme/app_colors.dart';
import 'package:vendure_flutter_app/core/theme/app_text_styles.dart';

class OptionChip extends StatelessWidget {
  const OptionChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        constraints: const BoxConstraints(minWidth: 60),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: selected
                ? AppColors.primaryNavy
                : (isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB)),
          ),
          color: selected
              ? AppColors.primaryNavy.withValues(alpha: 0.08)
              : Colors.transparent,
        ),
        child: Text(
          label.toUpperCase(),
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall.copyWith(
            color: selected
                ? AppColors.primaryNavy
                : (isDark ? Colors.white70 : AppColors.textSecondary),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
