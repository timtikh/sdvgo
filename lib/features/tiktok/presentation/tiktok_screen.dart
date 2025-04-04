import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../domain/cubit/tiktok_cubit.dart';
import '../domain/cubit/tiktok_state.dart';
import 'widgets/zoomable_video_player.dart';

class TikTokScreen extends StatefulWidget {
  const TikTokScreen({super.key});

  @override
  _TikTokScreenState createState() => _TikTokScreenState();
}

class _TikTokScreenState extends State<TikTokScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool _isFullScreen = false; // Track full screen state

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_pageListener);
    context.read<TikTokCubit>().loadInitialVideos();
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }

  void _pageListener() {
    final currentPage = _pageController.page?.round() ?? 0;
    if (currentPage != _currentIndex) {
      _currentIndex = currentPage;
      _handlePageChange();
    }
  }

  void _handlePageChange() {
    final cubit = context.read<TikTokCubit>();

    if (_currentIndex > 0) {
      cubit.pauseVideo(_currentIndex - 1);
    }

    cubit.playVideo(_currentIndex);
    cubit.preloadVideos(_currentIndex);

    if (_currentIndex >= cubit.state.videos.length - 2) {
      cubit.loadMoreVideos();
    }
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
                  onPressed: () =>
                      context.read<TikTokCubit>().loadInitialVideos(),
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
              final controller =
                  context.read<TikTokCubit>().getController(index);
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
}
