import 'package:dartz/dartz.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/shipping_method.dart';
import 'package:vendure_flutter_app/shared/models/create_address_input.dart';

import '../../../../core/errors/failures.dart';
import '../entities/active_order.dart';

abstract class CartRepository {
  Future<Either<Failure, ActiveOrder?>> fetchActiveOrder();

  Future<Either<Failure, List<ShippingMethod>>> fetchEligibleShippingMethods({
    String? vendureToken,
  });

  Future<Either<Failure, void>> setShippingMethod({required String methodId});

  Future<Either<Failure, void>> setShippingAddress({
    required CreateAddressInput address,
  });
  Future<Either<Failure, void>> setBillingAddress({
    required CreateAddressInput address,
  });
}

abstract class OrderLineRepository {
  Future<Either<Failure, void>> addItemToOrder({
    required String productVariantId,
    required int quantity,
  });

  Future<Either<Failure, ActiveOrder>> adjustOrderItemQuantity({
    required String orderLineId,
    required int quantity,
  });

  Future<Either<Failure, ActiveOrder>> removeOrderLine({
    required String orderLineId,
  });

  Future<Either<Failure, ActiveOrder>> removeAllOrderLine();
}
