import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vendure_flutter_app/app/router/app_routes.dart';
import 'package:vendure_flutter_app/core/theme/app_colors.dart';
import 'package:vendure_flutter_app/core/theme/app_spacing.dart';
import 'package:vendure_flutter_app/core/theme/app_text_styles.dart';
import 'package:vendure_flutter_app/features/auth/application/controllers/auth_controllers.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_controller.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_state.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/order_address_controller.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/shipping_methods_controller.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/shipping_methods_state.dart';
import 'package:vendure_flutter_app/features/cart/application/providers/cart_providers.dart';
import 'package:vendure_flutter_app/features/cart/presentation/widgets/address_selection_section.dart';
import 'package:vendure_flutter_app/features/cart/presentation/widgets/set_address_section.dart';
import 'package:vendure_flutter_app/features/cart/presentation/widgets/set_customer_information_section.dart';
import 'package:vendure_flutter_app/features/cart/presentation/widgets/shipping_method_card.dart';
import 'package:vendure_flutter_app/shared/widgets/app_button.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final currentAddress = ref.read(shippingAddressProvider);
      if (currentAddress != null && currentAddress.isEmpty) {
        await ref.read(orderAddressControllerProvider.notifier).unsetAddress();
      }
      ref
          .read(shippingMethodsControllerProvider.notifier)
          .fetchEligibleShippingMethods();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(shippingMethodsControllerProvider);
    final cartState = ref.watch(cartControllerProvider);

    ref.listen(shippingAddressProvider, (previous, next) {
      if (next != null && next.isEmpty) {
        ref.read(orderAddressControllerProvider.notifier).unsetAddress();
      }
    });
    final isAuthenticated = ref.watch(isAuthenticatedProvider);
    final shippingAddress = ref.watch(shippingAddressProvider);
    final customer = cartState.customer;

    final hasShippingAddress =
        shippingAddress != null && !shippingAddress.isEmpty;
    final hasCustomer =
        customer != null &&
        customer.firstName.isNotEmpty &&
        customer.lastName.isNotEmpty &&
        customer.emailAddress.isNotEmpty;

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
              AppSpacing.vL,
              isAuthenticated
                  ? const AddressSelectionSection()
                  : const SetAddressSection(),
              AppSpacing.vL,
              if (!isAuthenticated) const SetCustomerInformationSection(),
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
            AppSpacing.vM,
            AppButton(
              text: 'Continue',
              onPressed: state.maybeWhen(
                success: (methods, selected) =>
                    (selected != null && hasShippingAddress && hasCustomer)
                    ? () {
                        context.pushNamed(AppRoute.payment.name);
                      }
                    : null,
                orElse: () => null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
