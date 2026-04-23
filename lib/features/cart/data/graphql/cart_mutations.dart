import 'package:vendure_flutter_app/shared/fragments/order_fragments.dart';

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

  static const adjustOrderLineMutation =
      '''
    mutation AdjustOrderLine(\$orderLineId: ID!, \$quantity: Int!) {
        adjustOrderLine(orderLineId : \$orderLineId, quantity: \$quantity) {
          __typename
          ... on Order {
          ${OrderFragments.orderFields}
          }

          ... on OrderModificationError{
            errorCode
            message
          }

          ... on InsufficientStockError{
            errorCode
            message
          }

          ... on OrderInterceptorError{
            errorCode
            message
          }
        }
    }
  ''';

  static const removeOrderLineMutation =
      '''
    mutation RemoveOrderLine(\$orderLineId: ID!) {
      removeOrderLine(orderLineId : \$orderLineId) {
        __typename
        ... on Order {
        ${OrderFragments.orderFields}
        }
        ... on OrderModificationError{
          errorCode
          message
        }
        ... on OrderInterceptorError{
          errorCode
          message
        }
      }
    }
  ''';

  static const removeAllOrderLineMutation =
      '''
    mutation RemoveAllOrderLines{
      removeAllOrderLines {
        __typename
        ... on Order {
        ${OrderFragments.orderFields}
        }
        ... on OrderModificationError{
          errorCode
          message
        }
        ... on OrderInterceptorError{
          errorCode
          message
        }
      }
    }
  ''';

  static const setOrderShippingMethodMutation =
      '''
    mutation SetOrderShippingMethod(\$shippingMethodId: [ID!]!){
      setOrderShippingMethod(shippingMethodId: \$shippingMethodId) {
        __typename
        ... on Order {
        ${OrderFragments.orderFields}
        }
        ... on OrderModificationError{
          errorCode
          message
        }
        ... on IneligibleShippingMethodError{
          errorCode
          message
        }
        ... on NoActiveOrderError{
          errorCode
          message
        }
      }
    }
  ''';
}
