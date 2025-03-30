import 'package:freezed_annotation/freezed_annotation.dart';
part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required int score,
    required int tiktokCount,
    required String name,
    required String surname,
  }) = _User;
}
