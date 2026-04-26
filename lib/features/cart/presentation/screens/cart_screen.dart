import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_controller.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_item_controller.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_item_state.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_state.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/active_order.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/cart_item_data.dart';
import 'package:vendure_flutter_app/features/cart/presentation/widgets/cart_empty_view.dart';
import 'package:vendure_flutter_app/features/cart/presentation/widgets/cart_error_view.dart';
import 'package:vendure_flutter_app/features/cart/presentation/widgets/cart_items_section.dart';
import 'package:vendure_flutter_app/features/cart/presentation/widgets/summary_section.dart';
import 'package:vendure_flutter_app/shared/widgets/custom_app_bar.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
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
        id: line.id,
        name: variant?.name ?? 'Product',
        variantLabel: variant?.name ?? '',
        imageUrl:
            line.featuredAsset?.preview ??
            line.featuredAsset?.source ??
            variant?.previewImage ??
            "",
        price: line.unitPriceWithTax / 100,
        quantity: line.quantity,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartControllerProvider);

    ref.listen(cartItemControllerProvider, (previous, next) {
      next.maybeWhen(
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.red),
          );
        },
        orElse: () {},
      );
    });

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
          final shipping = activeOrder.shippingWithTax > 0
              ? activeOrder.shippingWithTax / 100
              : null;
          final tax = (activeOrder.subTotalWithTax - activeOrder.subTotal) > 0
              ? (activeOrder.subTotalWithTax - activeOrder.subTotal) / 100
              : null;

          return RefreshIndicator(
            onRefresh: () =>
                ref.read(cartControllerProvider.notifier).fetchActiveOrder(),
            child: _CartLoadedView(
              items: _toCartItems(activeOrder.lines),
              shippingFee: shipping,
              taxFee: tax,
              totalWithTax: activeOrder.totalWithTax / 100,
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(CartState cartState) {
    final itemCount = cartState.maybeWhen(
      success: (order) => order?.lines.length ?? 0,
      orElse: () => 0,
    );

    return CustomAppBar(
      title: 'Shopping Cart',
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

        PopupMenuButton<String>(
          icon: const Icon(Icons.more_horiz),
          menuPadding: EdgeInsetsGeometry.zero,
          color: AppColors.neutralGray,
          onSelected: (value) {
            if (value == 'delete_all') {
              ref
                  .read(cartItemControllerProvider.notifier)
                  .removeAllOrderLine();
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'delete_all',
              enabled: itemCount > 0,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                'Delete all',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        AppSpacing.hXS,
      ],
      showLeadingWidget: false,
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
    required this.totalWithTax,
  });

  final List<CartItemData> items;
  final double? shippingFee;
  final double? taxFee;
  final double totalWithTax;

  @override
  Widget build(BuildContext context) {
    final subtotal = items.fold<double>(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );
    final orderTotal = totalWithTax;

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
              AppSpacing.vM,
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
