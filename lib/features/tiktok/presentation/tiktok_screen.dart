import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'cubit/tiktok_cubit.dart';
import 'cubit/tiktok_state.dart';
import 'dart:core'; // For using URIs

class TikTokScreen extends StatefulWidget {
  const TikTokScreen({Key? key}) : super(key: key);

  @override
  _TikTokScreenState createState() => _TikTokScreenState();
}

class _TikTokScreenState extends State<TikTokScreen> {
  final PageController _pageController = PageController();
  final Map<int, VideoPlayerController> _controllers = {};
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<TikTokCubit>().loadInitialVideos();
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _initializeController(int index, Uri videoUri) async {
    if (_controllers.containsKey(index)) return;

    final controller = VideoPlayerController.networkUrl(videoUri);
    _controllers[index] = controller;

    try {
      await controller.initialize();
      controller.setLooping(true);

      
      // Auto-play the first video
      if (index == 0) {
        controller.play();
      }

    } catch (e) {
      print('Error initializing video controller: $e');
      _controllers.remove(index);
    }
  }

  void _handlePageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });

    for (var entry in _controllers.entries) {
      if (entry.key != index) {
        entry.value.pause();
      }
    }

    _controllers[index]?.play();

    if (index >= context.read<TikTokCubit>().state.videos.length - 2) {
      context.read<TikTokCubit>().preloadNextVideo();
    }

    if (index >= context.read<TikTokCubit>().state.videos.length - 1) {
      context.read<TikTokCubit>().loadMoreVideos();
    }

    _cleanupOldControllers();
  }

  void _cleanupOldControllers() {
    final keysToRemove = _controllers.keys.where((key) =>
      key < _currentIndex - 2 || key > _currentIndex + 2
    ).toList();
    
    for (var key in keysToRemove) {
      _controllers[key]?.dispose();
      _controllers.remove(key);
    }
  }
  // Created separate issue for this
  double _getScaleFactor(VideoPlayerController controller) {
    final double videoAspect = controller.value.aspectRatio;
    final double screenAspect = MediaQuery.of(context).size.width /
        MediaQuery.of(context).size.height;

    if (videoAspect < 1) {
      return screenAspect / videoAspect ;
    }
    return 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TikTokCubit, TikTokState>(
      builder: (context, state) {
        if (state.status == TikTokStatus.initial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == TikTokStatus.error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.error}'),
                ElevatedButton(
                  onPressed: () => context.read<TikTokCubit>().refreshVideos(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state.videos.isEmpty && state.status == TikTokStatus.initial) {
          return const Center(child: Text('Initing, please wait'));
        } else if (state.videos.isEmpty) {
          return const Center(child: Text('No videos available'));
        }

        return PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: state.videos.length + (state.hasMore ? 1 : 0),
          controller: _pageController,
          onPageChanged: _handlePageChanged,
          itemBuilder: (context, index) {
            if (index >= state.videos.length) {
              return const Center(child: CircularProgressIndicator());
            }

            final video = state.videos[index];
            final controller = _controllers[index];

            // Initialize controller if needed
            if (controller == null) {
              _initializeController(index, video.uri);
            }

            if (controller == null || !controller.value.isInitialized) {
              return const Center(child: CircularProgressIndicator());
            }

            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Center(
                  // also issue
                  child: ClipRect(
                    child: AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    ),
                  ),
                ),
                VideoProgressIndicator(
                  controller,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    playedColor: Colors.red,
                    bufferedColor: Colors.grey,
                    backgroundColor: Colors.black,
                  ),
                ),
                // У меня также есть лайки ники и названия видосов можем их добавить
              ],
            );
          },
        );
      },
    );
  }
}
