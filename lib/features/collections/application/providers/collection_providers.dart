import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/graphql_client.dart';
import '../../data/datasources/collection_remote_datasource.dart';
import '../../data/repositories/collection_repository_impl.dart';
import '../../domain/repositories/collection_repository.dart';
import '../../domain/entities/collection.dart';

part 'collection_providers.g.dart';

@riverpod
CollectionRemoteDataSource collectionRemoteDataSource(Ref ref) {
  final graphqlService = ref.watch(graphqlServiceProvider);
  return CollectionRemoteDataSourceImpl(graphqlService);
}

@riverpod
CollectionRepository collectionRepository(Ref ref) {
  final remoteDataSource = ref.watch(collectionRemoteDataSourceProvider);
  return CollectionRepositoryImpl(remoteDataSource);
}

@riverpod
Future<List<Collection>> collectionsList(Ref ref) async {
  final repository = ref.watch(collectionRepositoryProvider);
  final result = await repository.getCollections(take: 10, skip: 0);
  
  return result.fold(
    (failure) => throw Exception(failure.message),
    (collections) => collections,
  );
}
