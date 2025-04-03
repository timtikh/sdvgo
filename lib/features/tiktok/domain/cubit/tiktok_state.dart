import 'package:equatable/equatable.dart';
import '../../domain/video.dart';

enum TikTokStatus { initial, loading, success, error }

class TikTokState extends Equatable {
  final TikTokStatus status;
  final List<Video> videos;
  final String? error;
  final bool hasMore;
  final bool isLoadingMore;
  final int currentIndex;
  final Video? preloadedVideo;
  final List<Video> preloadedVideos;

  const TikTokState({
    this.status = TikTokStatus.initial,
    this.videos = const [],
    this.error,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.currentIndex = 0,
    this.preloadedVideo,
    this.preloadedVideos = const [],
  });

  TikTokState copyWith({
    TikTokStatus? status,
    List<Video>? videos,
    String? error,
    bool? hasMore,
    bool? isLoadingMore,
    int? currentIndex,
    Video? preloadedVideo,
    List<Video>? preloadedVideos,
  }) {
    return TikTokState(
      status: status ?? this.status,
      videos: videos ?? this.videos,
      error: error ?? this.error,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentIndex: currentIndex ?? this.currentIndex,
      preloadedVideo: preloadedVideo ?? this.preloadedVideo,
      preloadedVideos: preloadedVideos ?? this.preloadedVideos,
    );
  }

  @override
  List<Object?> get props => [
        status,
        videos,
        error,
        hasMore,
        isLoadingMore,
        currentIndex,
        preloadedVideo,
        preloadedVideos
      ];
}
