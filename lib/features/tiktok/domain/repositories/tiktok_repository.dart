import 'package:cloud_firestore/cloud_firestore.dart';
import '../video.dart';

abstract class TikTokRepository {
  Future<List<Video>> getVideos({int limit = 10, int offset = 0});
  Future<void> cacheVideos(List<Video> videos);
  Future<List<Video>> getCachedVideos({int limit = 10, int offset = 0});
  Future<void> clearCache();
} 