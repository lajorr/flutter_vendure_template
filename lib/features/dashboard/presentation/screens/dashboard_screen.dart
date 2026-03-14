import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../products/presentation/screens/home_screen.dart';
import '../../application/dashboard_controller.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(dashboardControllerProvider);

    final tabs = [
      const HomeScreen(),
      const Scaffold(
        body: Center(
          child: Text(
            'Search Screen (Pending Layout)',
            style: AppTextStyles.h1,
          ),
        ),
      ),
      const Scaffold(
        body: Center(
          child: Text('Cart Screen (Pending Layout)', style: AppTextStyles.h1),
        ),
      ),
      const Scaffold(
        body: Center(
          child: Text(
            'Profile Screen (Pending Layout)',
            style: AppTextStyles.h1,
          ),
        ),
      ),
    ];

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: tabs),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) =>
            ref.read(dashboardControllerProvider.notifier).setIndex(index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryNavy,
        unselectedItemColor: AppColors.textSecondary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
