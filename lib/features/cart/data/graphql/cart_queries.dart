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

  static const String customAddressesQuery = r'''
    query ActiveCustomer {
        activeCustomer {
            addresses {
                id
                fullName
                company
                streetLine1
                streetLine2
                city
                province
                postalCode
                phoneNumber
                defaultShippingAddress
                defaultBillingAddress
                customFields
                country {
                    id
                    code
                    name
                    customFields
                }
            }
        }
    }
  ''';

  static const String eligiblePaymentMethodsQuery = r'''
    query EligiblePaymentMethods {
      eligiblePaymentMethods {
        id
        code
        name
        description
        isEligible
        eligibilityMessage
        customFields
      }
    }
  ''';
}
