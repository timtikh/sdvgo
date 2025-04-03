import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';
import '../../domain/repositories/tiktok_repository.dart';
import 'tiktok_state.dart';
import '../../domain/video.dart';
import 'dart:async';

class TikTokCubit extends Cubit<TikTokState> {
  final TikTokRepository _repository;
  static const int _pageSize = 5;
  DocumentSnapshot? _lastDocument;
  bool _isPreloading = false;

  // New logic of caching and dicposing
  final Map<int, VideoPlayerController> _activeControllers = {};
  Timer? _cleanupTimer;

  TikTokCubit(this._repository) : super(const TikTokState()) {
    _cleanupTimer = Timer.periodic(
        const Duration(seconds: 30), (_) => _cleanupUnusedControllers());
  }

  void _cleanupUnusedControllers() {
    final currentIndex = state.currentIndex;
    final videos = state.videos;

    final keepIndices = {
      currentIndex,
      if (currentIndex > 0) currentIndex - 1,
      if (currentIndex < videos.length - 1) currentIndex + 1,
    };

    _activeControllers.removeWhere((index, controller) {
      if (!keepIndices.contains(index)) {
        controller.dispose();
        return true;
      }
      return false;
    });
  }

  @override
  Future<void> close() {
    _cleanupTimer?.cancel();
    for (var controller in _activeControllers.values) {
      controller.dispose();
    }
    _activeControllers.clear();
    return super.close();
  }

  Future<void> loadInitialVideos() async {
    if (state.status == TikTokStatus.loading) return;

    emit(state.copyWith(status: TikTokStatus.loading));

    try {
      _lastDocument = null;
      final videos = await _repository.getVideos(limit: _pageSize);

      // Init of first vid
      if (videos.isNotEmpty) {
        await _initializeController(0, videos[0], true);
      }

      emit(state.copyWith(
        status: TikTokStatus.success,
        videos: videos,
        hasMore: videos.length >= _pageSize,
        currentIndex: 0,
      ));

      if (videos.isNotEmpty) {
        _lastDocument = await _repository.getLastDocument(videos.last.id);
        if (videos.length > 1) {
          await _initializeController(1, videos[1], false);
        }
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
        emit(state.copyWith(hasMore: false));
        return;
      }

      _lastDocument = await _repository.getLastDocument(moreVideos.last.id);

      emit(state.copyWith(
        videos: [...state.videos, ...moreVideos],
        hasMore: moreVideos.length >= _pageSize,
        isLoadingMore: false,
      ));

      if (moreVideos.isNotEmpty) {
        await _initializeController(
            state.videos.length - moreVideos.length, moreVideos[0], false);
      }
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        isLoadingMore: false,
      ));
    }
  }

  Future<void> _initializeController(
      int index, Video video, bool autoPlay) async {
    if (_activeControllers.containsKey(index)) return;

    final controller = VideoPlayerController.networkUrl(video.uri);
    await controller.initialize();
    controller.setLooping(true);

    _activeControllers[index] = controller;

    if (autoPlay) {
      await controller.play();
    }

    emit(state.copyWith());
  }

  Future<void> playVideo(int index) async {
    if (index < 0 || index >= state.videos.length) return;

    final video = state.videos[index];
    if (!_activeControllers.containsKey(index)) {
      await _initializeController(index, video, true);
    } else {
      await _activeControllers[index]!.play();
    }

    emit(state.copyWith(currentIndex: index));
  }

  Future<void> pauseVideo(int index) async {
    if (index < 0 || index >= state.videos.length) return;

    final controller = _activeControllers[index];
    if (controller != null && controller.value.isInitialized) {
      await controller.pause();
      emit(state.copyWith());
    }
  }

  Future<void> preloadVideos(int currentIndex) async {
    if (_isPreloading) return;
    _isPreloading = true;

    try {
      final videos = state.videos;

      for (int i = 1; i <= 2; i++) {
        final nextIndex = currentIndex + i;
        if (nextIndex < videos.length) {
          await _initializeController(nextIndex, videos[nextIndex], false);
        }
      }
      emit(state.copyWith());
    } finally {
      _isPreloading = false;
    }
  }

  VideoPlayerController? getController(int index) {
    return _activeControllers[index];
  }
}
