import 'package:logger/logger.dart';
import 'package:vendure_flutter_app/core/errors/exceptions.dart';
import 'package:vendure_flutter_app/core/extensions/map_ext.dart';
import 'package:vendure_flutter_app/features/auth/data/graphql/auth_mutations.dart';
import 'package:vendure_flutter_app/features/auth/data/models/login_input.dart';
import 'package:vendure_flutter_app/features/auth/data/models/register_customer_input.dart';

import '../../../../core/network/graphql_service.dart';
import '../graphql/auth_queries.dart';
import '../models/customer_model.dart';

abstract class AuthRemoteDataSource {
  Future<CustomerModel?> getActiveCustomer();

  Future<void> login({required LoginInput loginInput});

  Future<void> registerCustomerAccount({
    required RegisterCustomerInput customerInput,
  });
}

final _logger = Logger();

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final GraphQLService _graphqlService;

  AuthRemoteDataSourceImpl(this._graphqlService);

  @override
  Future<CustomerModel?> getActiveCustomer() async {
    _logger.d('AuthRemoteDataSourceImpl: fetching active customer');
    try {
      final data = await _graphqlService.performQuery(
        AuthQueries.activeCustomerQuery,
        operationName: 'ActiveCustomer',
      );

      final customerData = data?['activeCustomer'];
      if (customerData == null) {
        _logger.w('AuthRemoteDataSourceImpl: active customer is null.');
        return null;
      }

      return CustomerModel.fromJson(customerData as Map<String, dynamic>);
    } catch (e, st) {
      _logger.e(
        'AuthRemoteDataSourceImpl: Failed to fetch active customer',
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  @override
  Future<void> login({required LoginInput loginInput}) async {
    final data = await _graphqlService.performMutation(
      AuthMutations.loginMutation,
      operationName: 'Login',
      variables: {
        "username": loginInput.username,
        "password": loginInput.password,
      },
    );

    final result = data["login"];
    if (result == null) {
      throw ServerException("No Data Found");
    }
    final typename = result["__typename"];
    switch (typename) {
      case "CurrentUser":
        return;
      case "NotVerifiedError":
        throw AccountNotVerifiedException(result["message"]);
      case "InvalidCredentialsError":
      case "NativeAuthStrategyError":
        throw ServerException(result["message"]);
      default:
        throw ServerException("Unexpected Error");
    }
  }

  @override
  Future<void> registerCustomerAccount({
    required RegisterCustomerInput customerInput,
  }) async {
    final data = await _graphqlService.performMutation(
      AuthMutations.registerCustomerAccountMutation,
      operationName: 'RegisterCustomerAccount',
      variables: {"input": customerInput.toJson().withoutNulls},
    );

    final result = data["registerCustomerAccount"];
    if (result == null) {
      throw ServerException("No Data Found");
    }
    final typename = result["__typename"];
    switch (typename) {
      case "Success":
        return;
      case "MissingPasswordError":
      case "NativeAuthStrategyError":
      case "PasswordValidationError":
        throw ServerException(result["message"]);
      default:
        throw ServerException("Unexpected Error");
    }
  }
}
