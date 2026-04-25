import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vendure_flutter_app/features/auth/presentation/screens/login_screen.dart';
import 'package:vendure_flutter_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:vendure_flutter_app/features/customer/presentation/screens/add_address_screen.dart';
import 'package:vendure_flutter_app/features/cart/presentation/screens/cart_payment_screen.dart';

import '../../features/cart/presentation/screens/cart_shipping_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/products/presentation/screens/product_detail_screen.dart';
import '../../features/products/presentation/screens/product_list_screen.dart';
import 'app_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoute.login.path,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoute.login.path,
        name: AppRoute.login.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoute.signup.path,
        name: AppRoute.signup.name,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: AppRoute.dashboard.path,
        name: AppRoute.dashboard.name,
        builder: (context, state) => const DashboardScreen(),
        routes: [
          GoRoute(
            path: AppRoute.products.path,
            name: AppRoute.products.name,
            builder: (context, state) => const ProductListScreen(),
          ),
          GoRoute(
            path: AppRoute.productDetail.path,
            name: AppRoute.productDetail.name,
            builder: (context, state) {
              final id = state.pathParameters['id'];
              return ProductDetailScreen(id: id ?? '');
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoute.checkout.path,
        name: AppRoute.checkout.name,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Checkout Screen (Pending Layout)')),
        ),
      ),
      GoRoute(
        path: AppRoute.shippingMethod.path,
        name: AppRoute.shippingMethod.name,
        builder: (context, state) => const CartShippingScreen(),
      ),
      GoRoute(
        path: AppRoute.addAddress.path,
        name: AppRoute.addAddress.name,
        builder: (context, state) {
          final args = state.extra as AddAddressScreenArgs;
          return AddAddressScreen(args: args);
        },
      ),
      GoRoute(
        path: AppRoute.payment.path,
        name: AppRoute.payment.name,
        builder: (context, state) => const CartPaymentScreen(),
      ),
      GoRoute(
        path: AppRoute.orders.path,
        name: AppRoute.orders.name,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Orders Screen (Pending Layout)')),
        ),
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Navigation Error: ${state.error}'))),
  );
});
