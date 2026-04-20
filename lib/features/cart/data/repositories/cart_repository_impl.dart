import 'package:dartz/dartz.dart';
import 'package:vendure_flutter_app/core/errors/repository_exception_handler.dart';
import 'package:vendure_flutter_app/features/cart/data/models/add_item_to_order_request.dart';
import 'package:vendure_flutter_app/features/cart/data/models/adjust_order_line_request.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/active_order.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_remote_datasource.dart';

class CartRepositoryImpl
    with RepositoryExceptionMixin
    implements CartRepository {
  final CartRemoteDataSource _remoteDataSource;

  CartRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, ActiveOrder?>> fetchActiveOrder() async {
    return exceptionHandler(() async {
      final response = await _remoteDataSource.fetchActiveOrder();
      return response.activeOrder?.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> addItemToOrder({
    required String productVariantId,
    required int quantity,
  }) async {
    return exceptionHandler(() async {
      await _remoteDataSource.addItemToOrder(
        request: AddItemToOrderRequest(
          productVariantId: productVariantId,
          quantity: quantity,
        ),
      );
    });
  }

  @override
  Future<Either<Failure, ActiveOrder>> adjustOrderItemQuantity({
    required String orderLineId,
    required int quantity,
  }) {
    return exceptionHandler(() async {
      final activerOrderModel = await _remoteDataSource.adjustOrderLine(
        orderLineRequest: AdjustOrderLineRequest(
          orderLineId: orderLineId,
          quantity: quantity,
        ),
      );
      return activerOrderModel.toEntity();
    });
  }

  @override
  Future<Either<Failure, ActiveOrder>> removeOrderLine({
    required String orderLineId,
  }) {
    return exceptionHandler(() async {
      final activerOrderModel = await _remoteDataSource.removeOrderLine(
        orderLineId: orderLineId,
      );
      return activerOrderModel.toEntity();
    });
  }

  @override
  Future<Either<Failure, ActiveOrder>> removeAllOrderLine() {
    return exceptionHandler(() async {
      final activerOrderModel = await _remoteDataSource.removeAllOrderLine();
      return activerOrderModel.toEntity();
    });
  }
}
