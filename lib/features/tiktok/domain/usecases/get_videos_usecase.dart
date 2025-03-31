import '../repositories/tiktok_repository.dart';
import '../video.dart';

class GetVideosUseCase {
  final TikTokRepository _repository;

  GetVideosUseCase(this._repository);

  Future<List<Video>> execute() async {
    try {
      final cachedVideos = await _repository.getCachedVideos();
      if (cachedVideos.isNotEmpty) {
        return cachedVideos;
      }
      final videos = await _repository.getVideos();
      await _repository.cacheVideos(videos);
      return videos;
    } catch (e) {
      throw Exception('Failed to get videos: $e');
    }
  }
} 