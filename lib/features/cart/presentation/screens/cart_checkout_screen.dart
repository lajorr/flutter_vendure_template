import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendure_flutter_app/app/router/app_routes.dart';
import 'package:vendure_flutter_app/core/theme/app_colors.dart';
import 'package:vendure_flutter_app/core/theme/app_spacing.dart';
import 'package:vendure_flutter_app/core/theme/app_text_styles.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_controller.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_state.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/payment_methods_controller.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/payment_methods_state.dart';
import 'package:vendure_flutter_app/features/cart/presentation/widgets/payment_method_card.dart';
import 'package:vendure_flutter_app/features/dashboard/application/dashboard_controller.dart';
import 'package:vendure_flutter_app/shared/widgets/app_button.dart';
import 'package:vendure_flutter_app/shared/widgets/app_dialog.dart';
import 'package:vendure_flutter_app/shared/widgets/custom_app_bar.dart';
import 'package:vendure_flutter_app/shared/widgets/order_summary/summary_row.dart';

class CartPaymentScreen extends ConsumerStatefulWidget {
  const CartPaymentScreen({super.key});

  @override
  ConsumerState<CartPaymentScreen> createState() => _CartPaymentScreenState();
}

class _CartPaymentScreenState extends ConsumerState<CartPaymentScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(paymentMethodsControllerProvider.notifier)
          .fetchEligiblePaymentMethods();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartControllerProvider);
    final paymentState = ref.watch(paymentMethodsControllerProvider);

    ref.listen(paymentMethodsControllerProvider, (previous, next) {
      next.maybeWhen(
        paymentSuccess: () {
          AppDialog.show(
            context: context,
            icon: const Icon(Icons.check_circle_outline),
            iconColor: AppColors.white,
            iconBackgroundColor: AppColors.successGreen,
            title: 'Order Placed!',
            description:
                'Your order has been successfully placed. Thank you for shopping with us!',
            primaryButtonText: 'View Orders',
            onPrimaryPressed: () {
              ref
                  .read(dashboardControllerProvider.notifier)
                  .setIndex(DashboardTabs.home);
              // Navigate to orders or home
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          );
        },
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        orElse: () {},
      );
    });

    return Scaffold(
      appBar: const CustomAppBar(title: 'Checkout'),
      body: cartState.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (message) => Center(child: Text(message)),
        success: (activeOrder) {
          if (activeOrder == null) {
            return const Center(child: Text('No active order found'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.l,
                vertical: AppSpacing.l,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Select Payment Method', style: AppTextStyles.h1),
                  AppSpacing.vXS,
                  Text(
                    'Choose how you\'d like to pay for your order.',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  AppSpacing.vL,
                  ?paymentState.whenOrNull(
                    initial: () => const SizedBox.shrink(),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (message) => Center(child: Text(message)),
                    success: (methods, selectedMethod) {
                      if (methods.isEmpty) {
                        return const Center(
                          child: Text('No payment methods available'),
                        );
                      }
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: methods.length,
                        separatorBuilder: (context, index) => AppSpacing.vM,
                        itemBuilder: (context, index) {
                          final method = methods[index];
                          return PaymentMethodCard(
                            method: method,
                            isSelected: selectedMethod?.id == method.id,
                          );
                        },
                      );
                    },
                  ),
                  AppSpacing.vXL,
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: cartState.maybeWhen(
        success: (activeOrder) {
          if (activeOrder == null) return null;
          final subtotal = activeOrder.subTotal / 100;
          final shipping = activeOrder.shipping / 100;
          final tax = (activeOrder.totalWithTax - activeOrder.total) / 100;
          final total = activeOrder.totalWithTax / 100;
          return _buildOrderSummary(
            activeOrder.totalQuantity,
            subtotal,
            shipping,
            tax,
            total,
          );
        },
        orElse: () => null,
      ),
    );
  }

  Widget _buildOrderSummary(
    int totalQuantity,
    double subtotal,
    double shipping,
    double tax,
    double total,
  ) {
    final paymentState = ref.watch(paymentMethodsControllerProvider);
    final selectedMethod = paymentState.selectedPaymentMethod;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, -4), // Shadow on top
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Order Summary', style: AppTextStyles.h2),
            AppSpacing.vL,
            SummaryRow(
              label: 'Subtotal ($totalQuantity items)',
              value: subtotal.toStringAsFixed(2),
            ),
            AppSpacing.vS,
            SummaryRow(
              label: 'Shipping Fee',
              value: shipping.toStringAsFixed(2),
            ),
            AppSpacing.vS,
            SummaryRow(label: 'Estimated Tax', value: tax.toStringAsFixed(2)),
            AppSpacing.vL,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Amount',
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: AppTextStyles.h1.copyWith(
                    color: AppColors.primaryNavy,
                    fontSize: 26,
                  ),
                ),
              ],
            ),
            AppSpacing.vL,
            AppButton(
              text: 'Place Order',
              isLoading: paymentState.maybeWhen(
                paymentProcessing: () => true,
                orElse: () => false,
              ),
              onPressed: selectedMethod == null
                  ? null
                  : () {
                      ref
                          .read(paymentMethodsControllerProvider.notifier)
                          .addPaymentToOrder();
                    },
              icon: Icons.shopping_cart_checkout,
            ),
            AppSpacing.vL,
            Center(
              child: Text(
                'By placing your order, you agree to our Terms of Service and Privacy Policy. Secure encrypted checkout.',
                textAlign: TextAlign.center,
                style: AppTextStyles.label.copyWith(
                  fontSize: 11,
                  color: AppColors.textSecondary.withValues(alpha: 0.8),
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
