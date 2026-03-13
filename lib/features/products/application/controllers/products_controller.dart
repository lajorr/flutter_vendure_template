import 'dart:async';

import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../providers/product_providers.dart';

part 'products_controller.g.dart';

final _logger = Logger();

@riverpod
class ProductsController extends _$ProductsController {
  @override
  FutureOr<List<Product>> build() async {
    _logger.i('Building ProductsController...');
    return _fetchProducts();
  }

  Future<List<Product>> _fetchProducts({int take = 20, int skip = 0}) async {
    _logger.d('Fetching products with take: $take, skip: $skip');
    final useCase = ref.read(getProductsUseCaseProvider);
    final result = await useCase.execute(
      ProductsParams(take: take, skip: skip),
    );

    return result.fold(
      (failure) {
        _logger.e('Failed to fetch products: ${failure.message}');
        throw Exception(failure.message);
      },
      (products) {
        _logger.d('Successfully fetched ${products.length} products');
        return products;
      },
    );
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.hasError) return;

    final currentProducts = state.value ?? [];

    // Maintain previous state while loading more
    // ignore: invalid_use_of_internal_member
    state = AsyncLoading<List<Product>>().copyWithPrevious(state);

    try {
      final newProducts = await _fetchProducts(skip: currentProducts.length);
      state = AsyncData([...currentProducts, ...newProducts]);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    try {
      final products = await _fetchProducts();
      state = AsyncData(products);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

@riverpod
Future<Product> productDetails(Ref ref, String slug) async {
  final useCase = ref.watch(getProductDetailsUseCaseProvider);
  final result = await useCase.execute(slug);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (product) => product,
  );
}
