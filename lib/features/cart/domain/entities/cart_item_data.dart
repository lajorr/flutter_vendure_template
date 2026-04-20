class CartItemData {
  const CartItemData({
    required this.name,
    required this.variantLabel,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  final String name;
  final String variantLabel;
  final String imageUrl;
  final double price;
  final int quantity;
}
