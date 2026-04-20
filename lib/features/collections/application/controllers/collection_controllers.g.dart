// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CollectionControllers)
final collectionControllersProvider = CollectionControllersProvider._();

final class CollectionControllersProvider
    extends $AsyncNotifierProvider<CollectionControllers, List<Collection>> {
  CollectionControllersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'collectionControllersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$collectionControllersHash();

  @$internal
  @override
  CollectionControllers create() => CollectionControllers();
}

String _$collectionControllersHash() =>
    r'ccfb1180f3e7940e292da2f8bca98b81ac0508c3';

abstract class _$CollectionControllers
    extends $AsyncNotifier<List<Collection>> {
  FutureOr<List<Collection>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<Collection>>, List<Collection>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Collection>>, List<Collection>>,
              AsyncValue<List<Collection>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
