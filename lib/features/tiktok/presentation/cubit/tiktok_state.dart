import 'package:equatable/equatable.dart';
import '../../domain/video.dart';

enum TikTokStatus { initial, loading, success, error }

class TikTokState extends Equatable {
  final TikTokStatus status;
  final List<Video> videos;
  final String? error;
  final bool hasMore;
  final bool isLoadingMore;

  const TikTokState({
    this.status = TikTokStatus.initial,
    this.videos = const [],
    this.error,
    this.hasMore = true,
    this.isLoadingMore = false,
  });

  TikTokState copyWith({
    TikTokStatus? status,
    List<Video>? videos,
    String? error,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return TikTokState(
      status: status ?? this.status,
      videos: videos ?? this.videos,
      error: error ?? this.error,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [status, videos, error, hasMore, isLoadingMore];
} 