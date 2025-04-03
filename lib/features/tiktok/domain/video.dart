import 'package:json_annotation/json_annotation.dart';
import 'package:video_player/video_player.dart';

part 'video.g.dart';

// может все-таки на фризд его перевести раз тут копивис понадобился
@JsonSerializable()
class Video {
  Video({
    required this.id,
    required this.user,
    required this.userPic,
    required this.videoTitle,
    required this.likes,
    required this.uri,
    this.controller,
  });

  final String id;
  final String user;
  final String userPic;
  final String videoTitle;
  final String likes;
  final Uri uri;

  @JsonKey(includeFromJson: false, includeToJson: false)
  VideoPlayerController? controller;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoToJson(this);

  Future<void> initializeController(bool autoPlay) async {
    controller = VideoPlayerController.networkUrl(uri);
    await controller!.initialize();
    controller!.setLooping(true);
    if (autoPlay) {
      controller!.play();
    }
  }

  Future<void> disposeController() async {
    await controller?.dispose();
    controller = null;
  }

  Video copyWith({
    VideoPlayerController? controller,
  }) {
    return Video(
      id: id,
      user: user,
      userPic: userPic,
      videoTitle: videoTitle,
      likes: likes,
      uri: uri,
      controller: controller ?? this.controller,
    );
  }
}
