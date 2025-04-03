import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdvgo/core/di/app_scope.dart';
import 'package:video_player/video_player.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';
import '../domain/cubit/tiktok_cubit.dart';
import '../domain/cubit/tiktok_state.dart';
import 'widgets/zoomable_video_player.dart';
import 'controllers/video_player_controller.dart';

class TikTokScreen extends StatefulWidget {
  const TikTokScreen({Key? key}) : super(key: key);

  @override
  _TikTokScreenState createState() => _TikTokScreenState();
}

class _TikTokScreenState extends State<TikTokScreen> {
  final PageController _pageController = PageController();
  final VideoPlayerControllerManager _videoControllerManager = VideoPlayerControllerManager();
  int _currentIndex = 0;
  bool _isFullScreen = false;

  @override
  Future<void> initState() async {
    super.initState();
    _pageController.addListener(_pageListener);
    await context.read<TikTokCubit>().loadInitialVideos();
    _videoControllerManager.initializeController(index, uri)context.read<TikTokCubit>().state.videos;
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    _videoControllerManager.disposeAll();
    super.dispose();
  }

  void _pageListener() {
    final currentPage = _pageController.page?.round() ?? 0;
    if (currentPage != _currentIndex) {
      _currentIndex = currentPage;
      _handlePageChange();
    }
  }

  Future<void> _handlePageChange() async {
    final cubit = context.read<TikTokCubit>();
    final state = cubit.state;

    if (_currentIndex > 0) {
      await _videoControllerManager.pauseVideo(_currentIndex - 1);
    }

    if (_currentIndex < state.videos.length) {
      final video = state.videos[_currentIndex];
      await _videoControllerManager.initializeController(_currentIndex, video.uri);
      await _videoControllerManager.playVideo(_currentIndex);
    }

    // Preload next videos
    for (int i = 1; i <= 2; i++) {
      final nextIndex = _currentIndex + i;
      if (nextIndex < state.videos.length) {
        final nextVideo = state.videos[nextIndex];
        await _videoControllerManager.initializeController(nextIndex, nextVideo.uri);
      }
    }

    if (_currentIndex >= state.videos.length - 2) {
      cubit.loadMoreVideos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopeBuilder<AppScopeContainer>.withPlaceholder(
      builder: (context, scope) {
        final tiktokCubit = scope.tiktokCubitDep.get;
        return BlocBuilder<TikTokCubit, TikTokState>(
          bloc: tiktokCubit,
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
                      onPressed: () => tiktokCubit.loadInitialVideos(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return GestureDetector(
              onDoubleTap: () {
                setState(() {
                  _isFullScreen = !_isFullScreen;
                });
              },
              child: PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.videos.length + (state.hasMore ? 1 : 0),
                controller: _pageController,
                itemBuilder: (context, index) {
                  if (index >= state.videos.length) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final controller = _videoControllerManager.getController(index);
                  if (controller == null || !controller.value.isInitialized) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ZoomableVideoPlayer(
                        controller: controller,
                        isFullScreen: _isFullScreen,
                      ),
                      VideoProgressIndicator(
                        controller,
                        allowScrubbing: true,
                        colors: const VideoProgressColors(
                          playedColor: Colors.red,
                          bufferedColor: Colors.grey,
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        );
      }
    );
  }
}