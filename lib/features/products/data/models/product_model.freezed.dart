// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductModel {

 String get id; String get name; String get slug; String? get description; bool get enabled; AssetModel? get featuredAsset; List<AssetModel> get assets; List<ProductVariantModel> get variants; List<ProductOptionGroupModel> get optionGroups; List<FacetValueModel> get facetValues;
/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductModelCopyWith<ProductModel> get copyWith => _$ProductModelCopyWithImpl<ProductModel>(this as ProductModel, _$identity);

  /// Serializes this ProductModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.description, description) || other.description == description)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.featuredAsset, featuredAsset) || other.featuredAsset == featuredAsset)&&const DeepCollectionEquality().equals(other.assets, assets)&&const DeepCollectionEquality().equals(other.variants, variants)&&const DeepCollectionEquality().equals(other.optionGroups, optionGroups)&&const DeepCollectionEquality().equals(other.facetValues, facetValues));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,description,enabled,featuredAsset,const DeepCollectionEquality().hash(assets),const DeepCollectionEquality().hash(variants),const DeepCollectionEquality().hash(optionGroups),const DeepCollectionEquality().hash(facetValues));

@override
String toString() {
  return 'ProductModel(id: $id, name: $name, slug: $slug, description: $description, enabled: $enabled, featuredAsset: $featuredAsset, assets: $assets, variants: $variants, optionGroups: $optionGroups, facetValues: $facetValues)';
}


}

/// @nodoc
abstract mixin class $ProductModelCopyWith<$Res>  {
  factory $ProductModelCopyWith(ProductModel value, $Res Function(ProductModel) _then) = _$ProductModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String slug, String? description, bool enabled, AssetModel? featuredAsset, List<AssetModel> assets, List<ProductVariantModel> variants, List<ProductOptionGroupModel> optionGroups, List<FacetValueModel> facetValues
});


$AssetModelCopyWith<$Res>? get featuredAsset;

}
/// @nodoc
class _$ProductModelCopyWithImpl<$Res>
    implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._self, this._then);

  final ProductModel _self;
  final $Res Function(ProductModel) _then;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? description = freezed,Object? enabled = null,Object? featuredAsset = freezed,Object? assets = null,Object? variants = null,Object? optionGroups = null,Object? facetValues = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,featuredAsset: freezed == featuredAsset ? _self.featuredAsset : featuredAsset // ignore: cast_nullable_to_non_nullable
as AssetModel?,assets: null == assets ? _self.assets : assets // ignore: cast_nullable_to_non_nullable
as List<AssetModel>,variants: null == variants ? _self.variants : variants // ignore: cast_nullable_to_non_nullable
as List<ProductVariantModel>,optionGroups: null == optionGroups ? _self.optionGroups : optionGroups // ignore: cast_nullable_to_non_nullable
as List<ProductOptionGroupModel>,facetValues: null == facetValues ? _self.facetValues : facetValues // ignore: cast_nullable_to_non_nullable
as List<FacetValueModel>,
  ));
}
/// Create a copy of ProductModel
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


/// Adds pattern-matching-related methods to [ProductModel].
extension ProductModelPatterns on ProductModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductModel value)  $default,){
final _that = this;
switch (_that) {
case _ProductModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String slug,  String? description,  bool enabled,  AssetModel? featuredAsset,  List<AssetModel> assets,  List<ProductVariantModel> variants,  List<ProductOptionGroupModel> optionGroups,  List<FacetValueModel> facetValues)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.description,_that.enabled,_that.featuredAsset,_that.assets,_that.variants,_that.optionGroups,_that.facetValues);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String slug,  String? description,  bool enabled,  AssetModel? featuredAsset,  List<AssetModel> assets,  List<ProductVariantModel> variants,  List<ProductOptionGroupModel> optionGroups,  List<FacetValueModel> facetValues)  $default,) {final _that = this;
switch (_that) {
case _ProductModel():
return $default(_that.id,_that.name,_that.slug,_that.description,_that.enabled,_that.featuredAsset,_that.assets,_that.variants,_that.optionGroups,_that.facetValues);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String slug,  String? description,  bool enabled,  AssetModel? featuredAsset,  List<AssetModel> assets,  List<ProductVariantModel> variants,  List<ProductOptionGroupModel> optionGroups,  List<FacetValueModel> facetValues)?  $default,) {final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.description,_that.enabled,_that.featuredAsset,_that.assets,_that.variants,_that.optionGroups,_that.facetValues);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductModel extends ProductModel {
  const _ProductModel({required this.id, required this.name, required this.slug, this.description, this.enabled = true, this.featuredAsset, final  List<AssetModel> assets = const [], final  List<ProductVariantModel> variants = const [], final  List<ProductOptionGroupModel> optionGroups = const [], final  List<FacetValueModel> facetValues = const []}): _assets = assets,_variants = variants,_optionGroups = optionGroups,_facetValues = facetValues,super._();
  factory _ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String slug;
@override final  String? description;
@override@JsonKey() final  bool enabled;
@override final  AssetModel? featuredAsset;
 final  List<AssetModel> _assets;
@override@JsonKey() List<AssetModel> get assets {
  if (_assets is EqualUnmodifiableListView) return _assets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assets);
}

 final  List<ProductVariantModel> _variants;
@override@JsonKey() List<ProductVariantModel> get variants {
  if (_variants is EqualUnmodifiableListView) return _variants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_variants);
}

 final  List<ProductOptionGroupModel> _optionGroups;
@override@JsonKey() List<ProductOptionGroupModel> get optionGroups {
  if (_optionGroups is EqualUnmodifiableListView) return _optionGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_optionGroups);
}

 final  List<FacetValueModel> _facetValues;
@override@JsonKey() List<FacetValueModel> get facetValues {
  if (_facetValues is EqualUnmodifiableListView) return _facetValues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_facetValues);
}


/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductModelCopyWith<_ProductModel> get copyWith => __$ProductModelCopyWithImpl<_ProductModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.description, description) || other.description == description)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.featuredAsset, featuredAsset) || other.featuredAsset == featuredAsset)&&const DeepCollectionEquality().equals(other._assets, _assets)&&const DeepCollectionEquality().equals(other._variants, _variants)&&const DeepCollectionEquality().equals(other._optionGroups, _optionGroups)&&const DeepCollectionEquality().equals(other._facetValues, _facetValues));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,description,enabled,featuredAsset,const DeepCollectionEquality().hash(_assets),const DeepCollectionEquality().hash(_variants),const DeepCollectionEquality().hash(_optionGroups),const DeepCollectionEquality().hash(_facetValues));

@override
String toString() {
  return 'ProductModel(id: $id, name: $name, slug: $slug, description: $description, enabled: $enabled, featuredAsset: $featuredAsset, assets: $assets, variants: $variants, optionGroups: $optionGroups, facetValues: $facetValues)';
}


}

/// @nodoc
abstract mixin class _$ProductModelCopyWith<$Res> implements $ProductModelCopyWith<$Res> {
  factory _$ProductModelCopyWith(_ProductModel value, $Res Function(_ProductModel) _then) = __$ProductModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String slug, String? description, bool enabled, AssetModel? featuredAsset, List<AssetModel> assets, List<ProductVariantModel> variants, List<ProductOptionGroupModel> optionGroups, List<FacetValueModel> facetValues
});


@override $AssetModelCopyWith<$Res>? get featuredAsset;

}
/// @nodoc
class __$ProductModelCopyWithImpl<$Res>
    implements _$ProductModelCopyWith<$Res> {
  __$ProductModelCopyWithImpl(this._self, this._then);

  final _ProductModel _self;
  final $Res Function(_ProductModel) _then;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? description = freezed,Object? enabled = null,Object? featuredAsset = freezed,Object? assets = null,Object? variants = null,Object? optionGroups = null,Object? facetValues = null,}) {
  return _then(_ProductModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,featuredAsset: freezed == featuredAsset ? _self.featuredAsset : featuredAsset // ignore: cast_nullable_to_non_nullable
as AssetModel?,assets: null == assets ? _self._assets : assets // ignore: cast_nullable_to_non_nullable
as List<AssetModel>,variants: null == variants ? _self._variants : variants // ignore: cast_nullable_to_non_nullable
as List<ProductVariantModel>,optionGroups: null == optionGroups ? _self._optionGroups : optionGroups // ignore: cast_nullable_to_non_nullable
as List<ProductOptionGroupModel>,facetValues: null == facetValues ? _self._facetValues : facetValues // ignore: cast_nullable_to_non_nullable
as List<FacetValueModel>,
  ));
}

/// Create a copy of ProductModel
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
