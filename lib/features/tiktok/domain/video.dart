import 'package:json_annotation/json_annotation.dart';

part 'video.g.dart';

@JsonSerializable()
class Video {
  const Video({
    required this.id,
    required this.user,
    required this.userPic,
    required this.videoTitle,
    required this.likes,
    required this.uri,
  });

  final String id;
  final String user;
  final String userPic;
  final String videoTitle;
  final String likes;
  final Uri uri;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoToJson(this);
}
