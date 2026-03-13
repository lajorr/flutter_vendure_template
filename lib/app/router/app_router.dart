import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/products/presentation/screens/product_detail_screen.dart';
import '../../features/products/presentation/screens/product_list_screen.dart';

import 'app_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoute.dashboard.path,
    debugLogDiagnostics: true,
    routes: [
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
              final slug = state.pathParameters['slug'];
              return ProductDetailScreen(slug: slug ?? '');
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
        path: AppRoute.orders.path,
        name: AppRoute.orders.name,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Orders Screen (Pending Layout)')),
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Navigation Error: ${state.error}')),
    ),
  );
});
