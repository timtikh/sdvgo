import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_statistics.freezed.dart';

@freezed
class UserStatistics with _$UserStatistics {
  const factory UserStatistics({
    required int clicksCount,
    required int tiktokCount,
    required int puffs,
    required int gamePoints,
  }) = _UserStatistics;
}
