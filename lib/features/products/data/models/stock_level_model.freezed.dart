// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_level_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StockLevelModel {

 int get stockOnHand; int get stockAllocated;
/// Create a copy of StockLevelModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockLevelModelCopyWith<StockLevelModel> get copyWith => _$StockLevelModelCopyWithImpl<StockLevelModel>(this as StockLevelModel, _$identity);

  /// Serializes this StockLevelModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockLevelModel&&(identical(other.stockOnHand, stockOnHand) || other.stockOnHand == stockOnHand)&&(identical(other.stockAllocated, stockAllocated) || other.stockAllocated == stockAllocated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stockOnHand,stockAllocated);

@override
String toString() {
  return 'StockLevelModel(stockOnHand: $stockOnHand, stockAllocated: $stockAllocated)';
}


}

/// @nodoc
abstract mixin class $StockLevelModelCopyWith<$Res>  {
  factory $StockLevelModelCopyWith(StockLevelModel value, $Res Function(StockLevelModel) _then) = _$StockLevelModelCopyWithImpl;
@useResult
$Res call({
 int stockOnHand, int stockAllocated
});




}
/// @nodoc
class _$StockLevelModelCopyWithImpl<$Res>
    implements $StockLevelModelCopyWith<$Res> {
  _$StockLevelModelCopyWithImpl(this._self, this._then);

  final StockLevelModel _self;
  final $Res Function(StockLevelModel) _then;

/// Create a copy of StockLevelModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stockOnHand = null,Object? stockAllocated = null,}) {
  return _then(_self.copyWith(
stockOnHand: null == stockOnHand ? _self.stockOnHand : stockOnHand // ignore: cast_nullable_to_non_nullable
as int,stockAllocated: null == stockAllocated ? _self.stockAllocated : stockAllocated // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StockLevelModel].
extension StockLevelModelPatterns on StockLevelModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockLevelModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockLevelModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockLevelModel value)  $default,){
final _that = this;
switch (_that) {
case _StockLevelModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockLevelModel value)?  $default,){
final _that = this;
switch (_that) {
case _StockLevelModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int stockOnHand,  int stockAllocated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockLevelModel() when $default != null:
return $default(_that.stockOnHand,_that.stockAllocated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int stockOnHand,  int stockAllocated)  $default,) {final _that = this;
switch (_that) {
case _StockLevelModel():
return $default(_that.stockOnHand,_that.stockAllocated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int stockOnHand,  int stockAllocated)?  $default,) {final _that = this;
switch (_that) {
case _StockLevelModel() when $default != null:
return $default(_that.stockOnHand,_that.stockAllocated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StockLevelModel extends StockLevelModel {
  const _StockLevelModel({required this.stockOnHand, required this.stockAllocated}): super._();
  factory _StockLevelModel.fromJson(Map<String, dynamic> json) => _$StockLevelModelFromJson(json);

@override final  int stockOnHand;
@override final  int stockAllocated;

/// Create a copy of StockLevelModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockLevelModelCopyWith<_StockLevelModel> get copyWith => __$StockLevelModelCopyWithImpl<_StockLevelModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StockLevelModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockLevelModel&&(identical(other.stockOnHand, stockOnHand) || other.stockOnHand == stockOnHand)&&(identical(other.stockAllocated, stockAllocated) || other.stockAllocated == stockAllocated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stockOnHand,stockAllocated);

@override
String toString() {
  return 'StockLevelModel(stockOnHand: $stockOnHand, stockAllocated: $stockAllocated)';
}


}

/// @nodoc
abstract mixin class _$StockLevelModelCopyWith<$Res> implements $StockLevelModelCopyWith<$Res> {
  factory _$StockLevelModelCopyWith(_StockLevelModel value, $Res Function(_StockLevelModel) _then) = __$StockLevelModelCopyWithImpl;
@override @useResult
$Res call({
 int stockOnHand, int stockAllocated
});




}
/// @nodoc
class __$StockLevelModelCopyWithImpl<$Res>
    implements _$StockLevelModelCopyWith<$Res> {
  __$StockLevelModelCopyWithImpl(this._self, this._then);

  final _StockLevelModel _self;
  final $Res Function(_StockLevelModel) _then;

/// Create a copy of StockLevelModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stockOnHand = null,Object? stockAllocated = null,}) {
  return _then(_StockLevelModel(
stockOnHand: null == stockOnHand ? _self.stockOnHand : stockOnHand // ignore: cast_nullable_to_non_nullable
as int,stockAllocated: null == stockAllocated ? _self.stockAllocated : stockAllocated // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
