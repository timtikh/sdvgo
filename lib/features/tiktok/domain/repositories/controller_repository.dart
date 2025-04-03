import 'package:video_player/video_player.dart';

abstract class TiktokControllerRepository {
  Future<void> initializeController(bool autoPlay);
  Future<void> disposeController();
  VideoPlayerController? getController ();
}