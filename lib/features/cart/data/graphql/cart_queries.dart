import 'package:vendure_flutter_app/shared/fragments/order_fragments.dart';

class CartQueries {
  static const String activeOrderQuery =
      '''
    query ActiveOrder {
        activeOrder {
          ${OrderFragments.orderFields}
        }
    }
  ''';

  static const String eligibleShippingMethodsQuery = r'''
    query EligibleShippingMethods {
      eligibleShippingMethods {
          id
          price
          priceWithTax
          code
          name
          description
          metadata
          customFields
      }
    }
  ''';
}
