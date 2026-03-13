import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/products/presentation/screens/product_detail_screen.dart';
import '../../features/products/presentation/screens/product_list_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/products',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/products',
        name: 'products',
        builder: (context, state) => const ProductListScreen(),
        routes: [
          GoRoute(
            path: ':slug',
            name: 'product_detail',
            builder: (context, state) {
              final slug = state.pathParameters['slug'];
              return ProductDetailScreen(slug: slug ?? '');
            },
          ),
        ],
      ),
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Cart Screen (Pending Layout)')),
        ),
      ),
      GoRoute(
        path: '/checkout',
        name: 'checkout',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Checkout Screen (Pending Layout)')),
        ),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Profile Screen (Pending Layout)')),
        ),
      ),
      GoRoute(
        path: '/orders',
        name: 'orders',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Orders Screen (Pending Layout)')),
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Navigation Error: \${state.error}')),
    ),
  );
});
