import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repositories/tiktok_repository.dart';
import 'tiktok_state.dart';

class TikTokCubit extends Cubit<TikTokState> {
  final TikTokRepository _repository;
  static const int _pageSize = 5;
  DocumentSnapshot? _lastDocument;
  bool _isPreloading = false;

  TikTokCubit(this._repository) : super(const TikTokState());

  Future<void> loadInitialVideos() async {
    if (state.status == TikTokStatus.loading) return;

    emit(state.copyWith(status: TikTokStatus.loading));

    try {
      _lastDocument = null;
      final videos = await _repository.getVideos(limit: _pageSize);
      emit(state.copyWith(
        status: TikTokStatus.success,
        videos: videos,
        hasMore: videos.length >= _pageSize,
      ));
      if (videos.isNotEmpty) {
        _lastDocument = await _repository.getLastDocument(videos.last.id);
        // Preload next batch immediately
        _preloadNextBatch();
      }
    } catch (e) {
      emit(state.copyWith(
        status: TikTokStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> loadMoreVideos() async {
    if (!state.hasMore || state.isLoadingMore || _lastDocument == null) return;

    emit(state.copyWith(isLoadingMore: true));

    try {
      final moreVideos = await _repository.getVideos(
        limit: _pageSize,
        startAfter: _lastDocument,
      );

      if (moreVideos.isEmpty) {
        emit(state.copyWith(
          hasMore: false,
          isLoadingMore: false,
        ));
        return;
      }

      _lastDocument = await _repository.getLastDocument(moreVideos.last.id);
      
      emit(state.copyWith(
        videos: [...state.videos, ...moreVideos],
        hasMore: moreVideos.length >= _pageSize,
        isLoadingMore: false,
      ));

      // Preload next batch immediately
      _preloadNextBatch();
    } catch (e) {
      emit(state.copyWith(
        status: TikTokStatus.error,
        error: e.toString(),
        isLoadingMore: false,
      ));
    }
  }

  Future<void> _preloadNextBatch() async {
    if (!state.hasMore || _isPreloading || _lastDocument == null) return;

    _isPreloading = true;

    try {
      final nextVideos = await _repository.getVideos(
        limit: _pageSize,
        startAfter: _lastDocument,
      );

      if (nextVideos.isNotEmpty) {
        emit(state.copyWith(
          preloadedVideos: nextVideos,
        ));
      }
    } catch (e) {
      print('Error preloading next batch: $e');
    } finally {
      _isPreloading = false;
    }
  }

  Future<void> preloadNextVideo() async {
    if (!state.hasMore || _isPreloading || _lastDocument == null) return;

    _isPreloading = true;

    try {
      final nextVideo = await _repository.getVideos(
        limit: 1,
        startAfter: _lastDocument,
      );

      if (nextVideo.isNotEmpty) {
        emit(state.copyWith(
          preloadedVideo: nextVideo.first,
        ));
      }
    } catch (e) {
      print('Error preloading next video: $e');
    } finally {
      _isPreloading = false;
    }
  }

  Future<void> refreshVideos() async {
    emit(const TikTokState());
    await loadInitialVideos();
  }
} 