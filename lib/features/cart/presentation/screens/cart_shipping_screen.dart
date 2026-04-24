import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendure_flutter_app/core/theme/app_colors.dart';
import 'package:vendure_flutter_app/core/theme/app_spacing.dart';
import 'package:vendure_flutter_app/core/theme/app_text_styles.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_controller.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_state.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/shipping_methods_controller.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/shipping_methods_state.dart';
import 'package:vendure_flutter_app/features/cart/presentation/widgets/address_selection_section.dart';
import 'package:vendure_flutter_app/features/cart/presentation/widgets/shipping_method_card.dart';
import 'package:vendure_flutter_app/shared/widgets/custom_app_bar.dart';

class CartShippingScreen extends ConsumerStatefulWidget {
  const CartShippingScreen({super.key});

  @override
  ConsumerState<CartShippingScreen> createState() =>
      _ShippingMethodScreenState();
}

class _ShippingMethodScreenState extends ConsumerState<CartShippingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(shippingMethodsControllerProvider.notifier)
          .fetchEligibleShippingMethods();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(shippingMethodsControllerProvider);
    final cartState = ref.watch(cartControllerProvider);

    final totalWithTax = cartState.maybeWhen(
      success: (activeOrder) => activeOrder?.totalWithTax ?? 0,
      orElse: () => 0,
    );
    final formattedTotal = '\$${(totalWithTax / 100).toStringAsFixed(2)}';

    return Scaffold(
      appBar: const CustomAppBar(title: 'Shipping', actions: []),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.m),
          child: Column(
            children: [
              const ShippingMethodCard(),
              const SizedBox(height: AppSpacing.l),
              const AddressSelectionSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.l,
          AppSpacing.m,
          AppSpacing.l,
          AppSpacing.l,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order Total',
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  formattedTotal,
                  style: AppTextStyles.h2.copyWith(
                    color: AppColors.primaryNavy,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.m),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: state.maybeWhen(
                  success: (methods, selected) => selected != null
                      ? () {
                          // Navigate to next step or handle selection
                        }
                      : null,
                  orElse: () => null,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryNavy,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppSpacing.radiusButton,
                    ),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
