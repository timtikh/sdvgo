import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/tiktok_repository.dart';
import 'tiktok_state.dart';

class TikTokCubit extends Cubit<TikTokState> {
  final TikTokRepository _repository;
  static const int _pageSize = 10;
  int _currentOffset = 0;

  TikTokCubit(this._repository) : super(const TikTokState());

  Future<void> loadInitialVideos() async {
    if (state.status == TikTokStatus.loading) return;

    emit(state.copyWith(status: TikTokStatus.loading));

    try {
      _currentOffset = 0;
      final videos = await _repository.getVideos(limit: _pageSize, offset: _currentOffset);
      emit(state.copyWith(
        status: TikTokStatus.success,
        videos: videos,
        hasMore: videos.length >= _pageSize,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TikTokStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> loadMoreVideos() async {
    if (!state.hasMore || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    try {
      _currentOffset += _pageSize;
      final moreVideos = await _repository.getVideos(
        limit: _pageSize,
        offset: _currentOffset,
      );

      if (moreVideos.isEmpty) {
        emit(state.copyWith(
          hasMore: false,
          isLoadingMore: false,
        ));
        return;
      }

      emit(state.copyWith(
        videos: [...state.videos, ...moreVideos],
        hasMore: moreVideos.length >= _pageSize,
        isLoadingMore: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TikTokStatus.error,
        error: e.toString(),
        isLoadingMore: false,
      ));
    }
  }

  Future<void> refreshVideos() async {
    emit(const TikTokState());
    await loadInitialVideos();
  }
} 