// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_option_group_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductOptionGroupModel {

 String get id; String get name; List<ProductOptionModel> get options;
/// Create a copy of ProductOptionGroupModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductOptionGroupModelCopyWith<ProductOptionGroupModel> get copyWith => _$ProductOptionGroupModelCopyWithImpl<ProductOptionGroupModel>(this as ProductOptionGroupModel, _$identity);

  /// Serializes this ProductOptionGroupModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductOptionGroupModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.options, options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(options));

@override
String toString() {
  return 'ProductOptionGroupModel(id: $id, name: $name, options: $options)';
}


}

/// @nodoc
abstract mixin class $ProductOptionGroupModelCopyWith<$Res>  {
  factory $ProductOptionGroupModelCopyWith(ProductOptionGroupModel value, $Res Function(ProductOptionGroupModel) _then) = _$ProductOptionGroupModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, List<ProductOptionModel> options
});




}
/// @nodoc
class _$ProductOptionGroupModelCopyWithImpl<$Res>
    implements $ProductOptionGroupModelCopyWith<$Res> {
  _$ProductOptionGroupModelCopyWithImpl(this._self, this._then);

  final ProductOptionGroupModel _self;
  final $Res Function(ProductOptionGroupModel) _then;

/// Create a copy of ProductOptionGroupModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? options = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<ProductOptionModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductOptionGroupModel].
extension ProductOptionGroupModelPatterns on ProductOptionGroupModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductOptionGroupModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductOptionGroupModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductOptionGroupModel value)  $default,){
final _that = this;
switch (_that) {
case _ProductOptionGroupModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductOptionGroupModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProductOptionGroupModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  List<ProductOptionModel> options)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductOptionGroupModel() when $default != null:
return $default(_that.id,_that.name,_that.options);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  List<ProductOptionModel> options)  $default,) {final _that = this;
switch (_that) {
case _ProductOptionGroupModel():
return $default(_that.id,_that.name,_that.options);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  List<ProductOptionModel> options)?  $default,) {final _that = this;
switch (_that) {
case _ProductOptionGroupModel() when $default != null:
return $default(_that.id,_that.name,_that.options);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductOptionGroupModel extends ProductOptionGroupModel {
  const _ProductOptionGroupModel({required this.id, required this.name, required final  List<ProductOptionModel> options}): _options = options,super._();
  factory _ProductOptionGroupModel.fromJson(Map<String, dynamic> json) => _$ProductOptionGroupModelFromJson(json);

@override final  String id;
@override final  String name;
 final  List<ProductOptionModel> _options;
@override List<ProductOptionModel> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}


/// Create a copy of ProductOptionGroupModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductOptionGroupModelCopyWith<_ProductOptionGroupModel> get copyWith => __$ProductOptionGroupModelCopyWithImpl<_ProductOptionGroupModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductOptionGroupModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductOptionGroupModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._options, _options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_options));

@override
String toString() {
  return 'ProductOptionGroupModel(id: $id, name: $name, options: $options)';
}


}

/// @nodoc
abstract mixin class _$ProductOptionGroupModelCopyWith<$Res> implements $ProductOptionGroupModelCopyWith<$Res> {
  factory _$ProductOptionGroupModelCopyWith(_ProductOptionGroupModel value, $Res Function(_ProductOptionGroupModel) _then) = __$ProductOptionGroupModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, List<ProductOptionModel> options
});




}
/// @nodoc
class __$ProductOptionGroupModelCopyWithImpl<$Res>
    implements _$ProductOptionGroupModelCopyWith<$Res> {
  __$ProductOptionGroupModelCopyWithImpl(this._self, this._then);

  final _ProductOptionGroupModel _self;
  final $Res Function(_ProductOptionGroupModel) _then;

/// Create a copy of ProductOptionGroupModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? options = null,}) {
  return _then(_ProductOptionGroupModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<ProductOptionModel>,
  ));
}


}

// dart format on
