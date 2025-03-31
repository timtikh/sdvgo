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
  final List<VideoPlayerController> _controllers = [];

  @override
  void initState() {
    super.initState();
    context.read<TikTokCubit>().loadInitialVideos();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();

    }
    _pageController.dispose();
    super.dispose();
  }

  void _initializeControllers(List<Uri> videoUris) {
    for (var uri in videoUris) {
      _controllers.add(VideoPlayerController.networkUrl(uri)
        ..initialize().then((_) {
          setState(() {});
        }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TikTokCubit, TikTokState>(
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

          if (state.videos.isEmpty) {
            return const Center(child: Text('No videos available'));
          }

          // Initialize controllers if needed
          if (_controllers.isEmpty) {
            _initializeControllers(state.videos.map((v) => v.uri).toList());
          }

          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: state.videos.length + (state.hasMore ? 1 : 0),
            controller: _pageController,
            onPageChanged: (index) {
              // Stop all videos
              for (var controller in _controllers) {
                controller.pause();
              }

              // If we're at the last item and there are more videos, load them
              if (index == state.videos.length - 1 && state.hasMore) {
                context.read<TikTokCubit>().loadMoreVideos();
              }

              // Play the current video
              if (index < _controllers.length) {
                _controllers[index].play();
              }
            },
            itemBuilder: (context, index) {
              if (index >= state.videos.length) {
                return const Center(child: CircularProgressIndicator());
              }

              final video = state.videos[index];
              if (index >= _controllers.length) {
                return const Center(child: CircularProgressIndicator());
              }

              return _controllers[index].value.isInitialized
                  ? Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        AspectRatio(
                          aspectRatio: _controllers[index].value.aspectRatio,
                          child: VideoPlayer(_controllers[index]),
                        ),
                        VideoProgressIndicator(
                          _controllers[index],
                          allowScrubbing: true,
                          colors: VideoProgressColors(
                            playedColor: Colors.red,
                            bufferedColor: Colors.grey,
                            backgroundColor: Colors.black,
                          ),
                        ),
                        Positioned(
                          bottom: 50,
                          child: Text(
                            video.videoTitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const Center(child: CircularProgressIndicator());
            },
          );
        },
      ),
    );
  }
}
