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
}
