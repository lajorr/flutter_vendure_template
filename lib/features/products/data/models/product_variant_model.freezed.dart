// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_variant_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductVariantModel {

 String get id; String get name; String get sku; int get price; AssetModel? get featuredAsset; List<AssetModel> get assets; String? get stockLevel;// @Default([]) List<StockLevelModel> stockLevels,
@JsonKey(name: "options") List<ProductOptionValueModel> get optionValues; List<FacetValueModel> get facetValues;
/// Create a copy of ProductVariantModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductVariantModelCopyWith<ProductVariantModel> get copyWith => _$ProductVariantModelCopyWithImpl<ProductVariantModel>(this as ProductVariantModel, _$identity);

  /// Serializes this ProductVariantModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductVariantModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.price, price) || other.price == price)&&(identical(other.featuredAsset, featuredAsset) || other.featuredAsset == featuredAsset)&&const DeepCollectionEquality().equals(other.assets, assets)&&(identical(other.stockLevel, stockLevel) || other.stockLevel == stockLevel)&&const DeepCollectionEquality().equals(other.optionValues, optionValues)&&const DeepCollectionEquality().equals(other.facetValues, facetValues));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,sku,price,featuredAsset,const DeepCollectionEquality().hash(assets),stockLevel,const DeepCollectionEquality().hash(optionValues),const DeepCollectionEquality().hash(facetValues));

@override
String toString() {
  return 'ProductVariantModel(id: $id, name: $name, sku: $sku, price: $price, featuredAsset: $featuredAsset, assets: $assets, stockLevel: $stockLevel, optionValues: $optionValues, facetValues: $facetValues)';
}


}

/// @nodoc
abstract mixin class $ProductVariantModelCopyWith<$Res>  {
  factory $ProductVariantModelCopyWith(ProductVariantModel value, $Res Function(ProductVariantModel) _then) = _$ProductVariantModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String sku, int price, AssetModel? featuredAsset, List<AssetModel> assets, String? stockLevel,@JsonKey(name: "options") List<ProductOptionValueModel> optionValues, List<FacetValueModel> facetValues
});


$AssetModelCopyWith<$Res>? get featuredAsset;

}
/// @nodoc
class _$ProductVariantModelCopyWithImpl<$Res>
    implements $ProductVariantModelCopyWith<$Res> {
  _$ProductVariantModelCopyWithImpl(this._self, this._then);

  final ProductVariantModel _self;
  final $Res Function(ProductVariantModel) _then;

/// Create a copy of ProductVariantModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? sku = null,Object? price = null,Object? featuredAsset = freezed,Object? assets = null,Object? stockLevel = freezed,Object? optionValues = null,Object? facetValues = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sku: null == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,featuredAsset: freezed == featuredAsset ? _self.featuredAsset : featuredAsset // ignore: cast_nullable_to_non_nullable
as AssetModel?,assets: null == assets ? _self.assets : assets // ignore: cast_nullable_to_non_nullable
as List<AssetModel>,stockLevel: freezed == stockLevel ? _self.stockLevel : stockLevel // ignore: cast_nullable_to_non_nullable
as String?,optionValues: null == optionValues ? _self.optionValues : optionValues // ignore: cast_nullable_to_non_nullable
as List<ProductOptionValueModel>,facetValues: null == facetValues ? _self.facetValues : facetValues // ignore: cast_nullable_to_non_nullable
as List<FacetValueModel>,
  ));
}
/// Create a copy of ProductVariantModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssetModelCopyWith<$Res>? get featuredAsset {
    if (_self.featuredAsset == null) {
    return null;
  }

  return $AssetModelCopyWith<$Res>(_self.featuredAsset!, (value) {
    return _then(_self.copyWith(featuredAsset: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProductVariantModel].
extension ProductVariantModelPatterns on ProductVariantModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductVariantModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductVariantModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductVariantModel value)  $default,){
final _that = this;
switch (_that) {
case _ProductVariantModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductVariantModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProductVariantModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String sku,  int price,  AssetModel? featuredAsset,  List<AssetModel> assets,  String? stockLevel, @JsonKey(name: "options")  List<ProductOptionValueModel> optionValues,  List<FacetValueModel> facetValues)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductVariantModel() when $default != null:
return $default(_that.id,_that.name,_that.sku,_that.price,_that.featuredAsset,_that.assets,_that.stockLevel,_that.optionValues,_that.facetValues);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String sku,  int price,  AssetModel? featuredAsset,  List<AssetModel> assets,  String? stockLevel, @JsonKey(name: "options")  List<ProductOptionValueModel> optionValues,  List<FacetValueModel> facetValues)  $default,) {final _that = this;
switch (_that) {
case _ProductVariantModel():
return $default(_that.id,_that.name,_that.sku,_that.price,_that.featuredAsset,_that.assets,_that.stockLevel,_that.optionValues,_that.facetValues);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String sku,  int price,  AssetModel? featuredAsset,  List<AssetModel> assets,  String? stockLevel, @JsonKey(name: "options")  List<ProductOptionValueModel> optionValues,  List<FacetValueModel> facetValues)?  $default,) {final _that = this;
switch (_that) {
case _ProductVariantModel() when $default != null:
return $default(_that.id,_that.name,_that.sku,_that.price,_that.featuredAsset,_that.assets,_that.stockLevel,_that.optionValues,_that.facetValues);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductVariantModel extends ProductVariantModel {
  const _ProductVariantModel({required this.id, required this.name, required this.sku, required this.price, this.featuredAsset, final  List<AssetModel> assets = const [], this.stockLevel, @JsonKey(name: "options") final  List<ProductOptionValueModel> optionValues = const [], final  List<FacetValueModel> facetValues = const []}): _assets = assets,_optionValues = optionValues,_facetValues = facetValues,super._();
  factory _ProductVariantModel.fromJson(Map<String, dynamic> json) => _$ProductVariantModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String sku;
@override final  int price;
@override final  AssetModel? featuredAsset;
 final  List<AssetModel> _assets;
@override@JsonKey() List<AssetModel> get assets {
  if (_assets is EqualUnmodifiableListView) return _assets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assets);
}

@override final  String? stockLevel;
// @Default([]) List<StockLevelModel> stockLevels,
 final  List<ProductOptionValueModel> _optionValues;
// @Default([]) List<StockLevelModel> stockLevels,
@override@JsonKey(name: "options") List<ProductOptionValueModel> get optionValues {
  if (_optionValues is EqualUnmodifiableListView) return _optionValues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_optionValues);
}

 final  List<FacetValueModel> _facetValues;
@override@JsonKey() List<FacetValueModel> get facetValues {
  if (_facetValues is EqualUnmodifiableListView) return _facetValues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_facetValues);
}


/// Create a copy of ProductVariantModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductVariantModelCopyWith<_ProductVariantModel> get copyWith => __$ProductVariantModelCopyWithImpl<_ProductVariantModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductVariantModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductVariantModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.price, price) || other.price == price)&&(identical(other.featuredAsset, featuredAsset) || other.featuredAsset == featuredAsset)&&const DeepCollectionEquality().equals(other._assets, _assets)&&(identical(other.stockLevel, stockLevel) || other.stockLevel == stockLevel)&&const DeepCollectionEquality().equals(other._optionValues, _optionValues)&&const DeepCollectionEquality().equals(other._facetValues, _facetValues));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,sku,price,featuredAsset,const DeepCollectionEquality().hash(_assets),stockLevel,const DeepCollectionEquality().hash(_optionValues),const DeepCollectionEquality().hash(_facetValues));

@override
String toString() {
  return 'ProductVariantModel(id: $id, name: $name, sku: $sku, price: $price, featuredAsset: $featuredAsset, assets: $assets, stockLevel: $stockLevel, optionValues: $optionValues, facetValues: $facetValues)';
}


}

/// @nodoc
abstract mixin class _$ProductVariantModelCopyWith<$Res> implements $ProductVariantModelCopyWith<$Res> {
  factory _$ProductVariantModelCopyWith(_ProductVariantModel value, $Res Function(_ProductVariantModel) _then) = __$ProductVariantModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String sku, int price, AssetModel? featuredAsset, List<AssetModel> assets, String? stockLevel,@JsonKey(name: "options") List<ProductOptionValueModel> optionValues, List<FacetValueModel> facetValues
});


@override $AssetModelCopyWith<$Res>? get featuredAsset;

}
/// @nodoc
class __$ProductVariantModelCopyWithImpl<$Res>
    implements _$ProductVariantModelCopyWith<$Res> {
  __$ProductVariantModelCopyWithImpl(this._self, this._then);

  final _ProductVariantModel _self;
  final $Res Function(_ProductVariantModel) _then;

/// Create a copy of ProductVariantModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? sku = null,Object? price = null,Object? featuredAsset = freezed,Object? assets = null,Object? stockLevel = freezed,Object? optionValues = null,Object? facetValues = null,}) {
  return _then(_ProductVariantModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sku: null == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,featuredAsset: freezed == featuredAsset ? _self.featuredAsset : featuredAsset // ignore: cast_nullable_to_non_nullable
as AssetModel?,assets: null == assets ? _self._assets : assets // ignore: cast_nullable_to_non_nullable
as List<AssetModel>,stockLevel: freezed == stockLevel ? _self.stockLevel : stockLevel // ignore: cast_nullable_to_non_nullable
as String?,optionValues: null == optionValues ? _self._optionValues : optionValues // ignore: cast_nullable_to_non_nullable
as List<ProductOptionValueModel>,facetValues: null == facetValues ? _self._facetValues : facetValues // ignore: cast_nullable_to_non_nullable
as List<FacetValueModel>,
  ));
}

/// Create a copy of ProductVariantModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssetModelCopyWith<$Res>? get featuredAsset {
    if (_self.featuredAsset == null) {
    return null;
  }

  return $AssetModelCopyWith<$Res>(_self.featuredAsset!, (value) {
    return _then(_self.copyWith(featuredAsset: value));
  });
}
}

// dart format on
