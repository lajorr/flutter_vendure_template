import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vendure_flutter_app/core/network/graphql_client.dart';
import 'package:vendure_flutter_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:vendure_flutter_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:vendure_flutter_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:vendure_flutter_app/features/auth/domain/usecases/get_active_customer_usecase.dart';

part 'auth_providers.g.dart';

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  final graphqlService = ref.watch(graphqlServiceProvider);
  return AuthRemoteDataSourceImpl(graphqlService);
}

@riverpod
AuthRepository authRepository(Ref ref) {
  final datasource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(datasource);
}

@riverpod
GetActiveCustomerUsecase getActiveCustomerUsecase(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return GetActiveCustomerUsecase(repository);
}
