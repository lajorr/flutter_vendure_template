// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(collectionRemoteDataSource)
final collectionRemoteDataSourceProvider =
    CollectionRemoteDataSourceProvider._();

final class CollectionRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          CollectionRemoteDataSource,
          CollectionRemoteDataSource,
          CollectionRemoteDataSource
        >
    with $Provider<CollectionRemoteDataSource> {
  CollectionRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'collectionRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$collectionRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<CollectionRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CollectionRemoteDataSource create(Ref ref) {
    return collectionRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollectionRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CollectionRemoteDataSource>(value),
    );
  }
}

String _$collectionRemoteDataSourceHash() =>
    r'5c98645affebeb9722b10ed866364d6779c508da';

@ProviderFor(collectionRepository)
final collectionRepositoryProvider = CollectionRepositoryProvider._();

final class CollectionRepositoryProvider
    extends
        $FunctionalProvider<
          CollectionRepository,
          CollectionRepository,
          CollectionRepository
        >
    with $Provider<CollectionRepository> {
  CollectionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'collectionRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$collectionRepositoryHash();

  @$internal
  @override
  $ProviderElement<CollectionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CollectionRepository create(Ref ref) {
    return collectionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollectionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CollectionRepository>(value),
    );
  }
}

String _$collectionRepositoryHash() =>
    r'04b8b5159d399b207708ee1d87ca4a6beaf55a0b';
