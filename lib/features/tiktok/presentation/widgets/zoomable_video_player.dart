import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ZoomableVideoPlayer extends StatelessWidget {
  final VideoPlayerController controller;
  final bool isFullScreen;
  final double zoomScale;

  const ZoomableVideoPlayer({
    Key? key,
    required this.controller,
    this.isFullScreen = false,
    this.zoomScale = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isFullScreen) {
      return Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ClipRect(
            child: Transform.scale(
              scale: zoomScale,
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: controller.value.size.width,
                  height: controller.value.size.height,
                  child: VideoPlayer(controller),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller),
      );
    }
  }
}
