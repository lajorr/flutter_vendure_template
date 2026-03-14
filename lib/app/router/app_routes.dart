enum AppRoute {
  dashboard('/dashboard'),
  products('products'),
  productDetail('product-detail/:id'),
  checkout('/checkout'),
  orders('/orders');

  final String path;
  const AppRoute(this.path);

  // The 'name' property is built-in to enums in Dart (e.g., AppRoute.dashboard.name returns 'dashboard')
}

class DashboardTabs {
  static const int home = 0;
  static const int search = 1;
  static const int cart = 2;
  static const int profile = 3;
}
