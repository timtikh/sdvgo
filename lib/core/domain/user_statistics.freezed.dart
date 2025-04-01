// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_statistics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserStatistics {
  int get clicksCount => throw _privateConstructorUsedError;
  int get tiktokCount => throw _privateConstructorUsedError;
  int get puffs => throw _privateConstructorUsedError;
  int get gamePoints => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserStatisticsCopyWith<UserStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStatisticsCopyWith<$Res> {
  factory $UserStatisticsCopyWith(
          UserStatistics value, $Res Function(UserStatistics) then) =
      _$UserStatisticsCopyWithImpl<$Res, UserStatistics>;
  @useResult
  $Res call({int clicksCount, int tiktokCount, int puffs, int gamePoints});
}

/// @nodoc
class _$UserStatisticsCopyWithImpl<$Res, $Val extends UserStatistics>
    implements $UserStatisticsCopyWith<$Res> {
  _$UserStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clicksCount = null,
    Object? tiktokCount = null,
    Object? puffs = null,
    Object? gamePoints = null,
  }) {
    return _then(_value.copyWith(
      clicksCount: null == clicksCount
          ? _value.clicksCount
          : clicksCount // ignore: cast_nullable_to_non_nullable
              as int,
      tiktokCount: null == tiktokCount
          ? _value.tiktokCount
          : tiktokCount // ignore: cast_nullable_to_non_nullable
              as int,
      puffs: null == puffs
          ? _value.puffs
          : puffs // ignore: cast_nullable_to_non_nullable
              as int,
      gamePoints: null == gamePoints
          ? _value.gamePoints
          : gamePoints // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserStatisticsImplCopyWith<$Res>
    implements $UserStatisticsCopyWith<$Res> {
  factory _$$UserStatisticsImplCopyWith(_$UserStatisticsImpl value,
          $Res Function(_$UserStatisticsImpl) then) =
      __$$UserStatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int clicksCount, int tiktokCount, int puffs, int gamePoints});
}

/// @nodoc
class __$$UserStatisticsImplCopyWithImpl<$Res>
    extends _$UserStatisticsCopyWithImpl<$Res, _$UserStatisticsImpl>
    implements _$$UserStatisticsImplCopyWith<$Res> {
  __$$UserStatisticsImplCopyWithImpl(
      _$UserStatisticsImpl _value, $Res Function(_$UserStatisticsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clicksCount = null,
    Object? tiktokCount = null,
    Object? puffs = null,
    Object? gamePoints = null,
  }) {
    return _then(_$UserStatisticsImpl(
      clicksCount: null == clicksCount
          ? _value.clicksCount
          : clicksCount // ignore: cast_nullable_to_non_nullable
              as int,
      tiktokCount: null == tiktokCount
          ? _value.tiktokCount
          : tiktokCount // ignore: cast_nullable_to_non_nullable
              as int,
      puffs: null == puffs
          ? _value.puffs
          : puffs // ignore: cast_nullable_to_non_nullable
              as int,
      gamePoints: null == gamePoints
          ? _value.gamePoints
          : gamePoints // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$UserStatisticsImpl implements _UserStatistics {
  const _$UserStatisticsImpl(
      {required this.clicksCount,
      required this.tiktokCount,
      required this.puffs,
      required this.gamePoints});

  @override
  final int clicksCount;
  @override
  final int tiktokCount;
  @override
  final int puffs;
  @override
  final int gamePoints;

  @override
  String toString() {
    return 'UserStatistics(clicksCount: $clicksCount, tiktokCount: $tiktokCount, puffs: $puffs, gamePoints: $gamePoints)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStatisticsImpl &&
            (identical(other.clicksCount, clicksCount) ||
                other.clicksCount == clicksCount) &&
            (identical(other.tiktokCount, tiktokCount) ||
                other.tiktokCount == tiktokCount) &&
            (identical(other.puffs, puffs) || other.puffs == puffs) &&
            (identical(other.gamePoints, gamePoints) ||
                other.gamePoints == gamePoints));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, clicksCount, tiktokCount, puffs, gamePoints);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStatisticsImplCopyWith<_$UserStatisticsImpl> get copyWith =>
      __$$UserStatisticsImplCopyWithImpl<_$UserStatisticsImpl>(
          this, _$identity);
}

abstract class _UserStatistics implements UserStatistics {
  const factory _UserStatistics(
      {required final int clicksCount,
      required final int tiktokCount,
      required final int puffs,
      required final int gamePoints}) = _$UserStatisticsImpl;

  @override
  int get clicksCount;
  @override
  int get tiktokCount;
  @override
  int get puffs;
  @override
  int get gamePoints;
  @override
  @JsonKey(ignore: true)
  _$$UserStatisticsImplCopyWith<_$UserStatisticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
