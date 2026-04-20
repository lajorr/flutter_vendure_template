class CartMutations {
  static const addItemToOrderMutation = r'''
    mutation AddItemToOrder($productVariantId: ID!, $quantity:Int!) {
        addItemToOrder(productVariantId: $productVariantId, quantity: $quantity) {
            ... on Order {
                id
            }
        }
    }
  ''';
}
