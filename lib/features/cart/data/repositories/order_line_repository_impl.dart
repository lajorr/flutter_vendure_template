import 'package:dartz/dartz.dart';
import 'package:vendure_flutter_app/core/errors/failures.dart';
import 'package:vendure_flutter_app/core/errors/repository_exception_handler.dart';
import 'package:vendure_flutter_app/features/cart/data/datasources/order_line_remote_datasource.dart';
import 'package:vendure_flutter_app/features/cart/data/models/add_item_to_order_request.dart';
import 'package:vendure_flutter_app/features/cart/data/models/adjust_order_line_request.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/active_order.dart';
import 'package:vendure_flutter_app/features/cart/domain/repositories/cart_repository.dart';

final class OrderLineRepositoryImpl
    with RepositoryExceptionMixin
    implements OrderLineRepository {
  final OrderLineRemoteDatasource _orderLineRemoteDatasource;

  OrderLineRepositoryImpl(this._orderLineRemoteDatasource);

  @override
  Future<Either<Failure, ActiveOrder>> removeAllOrderLine() {
    return exceptionHandler(() async {
      final activerOrderModel = await _orderLineRemoteDatasource
          .removeAllOrderLine();
      return activerOrderModel.toEntity();
    });
  }

  @override
  Future<Either<Failure, ActiveOrder>> adjustOrderItemQuantity({
    required String orderLineId,
    required int quantity,
  }) {
    return exceptionHandler(() async {
      final activerOrderModel = await _orderLineRemoteDatasource
          .adjustOrderLine(
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
      final activerOrderModel = await _orderLineRemoteDatasource
          .removeOrderLine(orderLineId: orderLineId);
      return activerOrderModel.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> addItemToOrder({
    required String productVariantId,
    required int quantity,
  }) async {
    return exceptionHandler(() async {
      await _orderLineRemoteDatasource.addItemToOrder(
        request: AddItemToOrderRequest(
          productVariantId: productVariantId,
          quantity: quantity,
        ),
      );
    });
  }
}
