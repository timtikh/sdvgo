import 'package:video_player/video_player.dart';

class VideoPlayerControllerManager {
  final Map<int, VideoPlayerController> _controllers = {};
  final int _maxControllers = 5;

  VideoPlayerController? controller(int index) => _controllers[index];

  Future<void> initializeController(int index, Uri uri) async {
    if (_controllers.containsKey(index)) {
      return;
    }

    if (_controllers.length >= _maxControllers) {
      final oldestIndex = _controllers.keys.first;
      await disposeController(oldestIndex);
    }

    final controller = VideoPlayerController.networkUrl(uri);
    _controllers[index] = controller;
    await controller.initialize();
  }

  Future<void> disposeController(int index) async {
    final controller = _controllers.remove(index);
    if (controller != null) {
      await controller.dispose();
    }
  }

  Future<void> disposeAll() async {
    for (final controller in _controllers.values) {
      await controller.dispose();
    }
    _controllers.clear();
  }

  Future<void> playVideo(int index) async {
    final controller = _controllers[index];
    if (controller != null && controller.value.isInitialized) {
      await controller.play();
    }
  }

  Future<void> pauseVideo(int index) async {
    final controller = _controllers[index];
    if (controller != null && controller.value.isInitialized) {
      await controller.pause();
    }
  }

  bool isControllerInitialized(int index) {
    final controller = _controllers[index];
    return controller != null && controller.value.isInitialized;
  }
} 