import 'package:video_player/video_player.dart';

import '../domain/cubit/tiktok_cubit.dart';
import '../domain/cubit/tiktok_state.dart';
import '../domain/repositories/controller_repository.dart';

class TiktokControllerRepositoryImpl implements TiktokControllerRepository {

  static final Map<int, VideoPlayerController> _activeControllers = {};
  VideoPlayerController? controller;
  Uri? uri;

  Future<void> initializeController(bool autoPlay) async {
    controller = VideoPlayerController.networkUrl(uri!);
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

  VideoPlayerController? getController (){
    return controller;
  }

}