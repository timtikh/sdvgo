import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repositories/tiktok_repository.dart';
import '../repositories/controller_repository.dart';
import 'tiktok_state.dart';
import '../../domain/video.dart';

class TikTokCubit extends Cubit<TikTokState> {
  final TikTokRepository _repository;

  static const int _pageSize = 5;
  DocumentSnapshot? _lastDocument;

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
        currentIndex: 0,
      ));

      if (videos.isNotEmpty) {
        _lastDocument = await _repository.getLastDocument(videos.last.id);
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
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        isLoadingMore: false,
      ));
    }
  }

}