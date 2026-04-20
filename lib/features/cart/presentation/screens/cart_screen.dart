import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_controller.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_state.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/active_order.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/cart_item_data.dart';
import 'package:vendure_flutter_app/features/cart/presentation/widgets/cart_empty_view.dart';
import 'package:vendure_flutter_app/features/cart/presentation/widgets/cart_error_view.dart';
import 'package:vendure_flutter_app/features/cart/presentation/widgets/cart_items_section.dart';
import 'package:vendure_flutter_app/features/cart/presentation/widgets/summary_section.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  static const _shippingFee = 12.50;
  static const _taxFee = 23.20;

  @override
  void initState() {
    super.initState();
    // Fetch the active order as soon as the screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cartControllerProvider.notifier).fetchActiveOrder();
    });
  }

  /// Maps [ActiveOrderLine]s to the [CartItemData] list expected by
  /// [CartItemsSection]. Price is converted from minor-units (cents) to major.
  List<CartItemData> _toCartItems(List<ActiveOrderLine> lines) {
    return lines.map((line) {
      final variant = line.productVariant;
      return CartItemData(
        name: variant?.name ?? 'Product',
        variantLabel: variant?.name ?? '', // Or line.id if no label available
        imageUrl: variant?.previewImage ?? "",
        price: line.unitPriceWithTax / 100,
        quantity: line.quantity,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(cartState),
      body: cartState.when(
        initial: () => const _CartLoadingView(),
        loading: () => const _CartLoadingView(),
        error: (message) => CartErrorView(
          message: message,
          onRetry: () =>
              ref.read(cartControllerProvider.notifier).fetchActiveOrder(),
        ),
        success: (activeOrder) {
          if (activeOrder == null || activeOrder.lines.isEmpty) {
            return RefreshIndicator(
              onRefresh: () =>
                  ref.read(cartControllerProvider.notifier).fetchActiveOrder(),
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: const CartEmptyView(),
                  ),
                ),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () =>
                ref.read(cartControllerProvider.notifier).fetchActiveOrder(),
            child: _CartLoadedView(
              items: _toCartItems(activeOrder.lines),
              shippingFee: _shippingFee,
              taxFee: _taxFee,
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(CartState cartState) {
    final itemCount = cartState.maybeWhen(
      success: (order) => order?.lines.length ?? 0,
      orElse: () => 0,
    );

    return AppBar(
      title: const Text('Shopping Cart'),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: AppSpacing.xs),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xs,
            vertical: AppSpacing.xxs,
          ),
          decoration: BoxDecoration(
            color: AppColors.neutralGray,
            borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
          ),
          child: Text(
            '$itemCount Items',
            style: AppTextStyles.label.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
        AppSpacing.hXS,
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Sub-views
// ---------------------------------------------------------------------------

class _CartLoadingView extends StatelessWidget {
  const _CartLoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _CartLoadedView extends StatelessWidget {
  const _CartLoadedView({
    required this.items,
    required this.shippingFee,
    required this.taxFee,
  });

  final List<CartItemData> items;
  final double shippingFee;
  final double taxFee;

  @override
  Widget build(BuildContext context) {
    final subtotal = items.fold<double>(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );
    final orderTotal = subtotal + shippingFee + taxFee;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 1024;

        if (isDesktop) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppSpacing.l),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 8, child: CartItemsSection(items: items)),
                AppSpacing.hL,
                Expanded(
                  flex: 4,
                  child: SummarySection(
                    subtotal: subtotal,
                    shipping: shippingFee,
                    tax: taxFee,
                    total: orderTotal,
                  ),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.m),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CartItemsSection(items: items),
              AppSpacing.vL,
              SummarySection(
                subtotal: subtotal,
                shipping: shippingFee,
                tax: taxFee,
                total: orderTotal,
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        );
      },
    );
  }
}
