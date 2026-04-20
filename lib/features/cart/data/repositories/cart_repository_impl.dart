import 'package:dartz/dartz.dart';
import 'package:vendure_flutter_app/features/cart/data/models/add_item_to_order_request.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/active_order.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_remote_datasource.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource _remoteDataSource;

  CartRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, ActiveOrder?>> fetchActiveOrder() async {
    try {
      final response = await _remoteDataSource.fetchActiveOrder();
      return Right(response.activeOrder?.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on AppTimeoutException catch (e) {
      return Left(TimeoutFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addItemToOrder({
    required String productVariantId,
    required int quantity,
  }) async {
    try {
      await _remoteDataSource.addItemToOrder(
        request: AddItemToOrderRequest(
          productVariantId: productVariantId,
          quantity: quantity,
        ),
      );
      return Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on AppTimeoutException catch (e) {
      return Left(TimeoutFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
