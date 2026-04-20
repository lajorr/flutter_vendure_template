import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vendure_flutter_app/features/collections/application/providers/collection_providers.dart';
import 'package:vendure_flutter_app/features/collections/domain/entities/collection.dart';

part 'collection_controllers.g.dart';

@riverpod
class CollectionControllers extends _$CollectionControllers {
  @override
  Future<List<Collection>> build() {
    return _fetchCollections();
  }

  Future<List<Collection>> _fetchCollections() async {
    final repository = ref.read(collectionRepositoryProvider);
    final result = await repository.getCollections(take: 10, skip: 0);

    return result.fold(
      (failure) => throw Exception(failure.message),
      (collections) => collections,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    try {
      final collections = await _fetchCollections();
      state = AsyncData(collections);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
