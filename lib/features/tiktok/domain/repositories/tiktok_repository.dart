import 'package:cloud_firestore/cloud_firestore.dart';
import '../video.dart';

abstract class TikTokRepository {
  Future<List<Video>> getVideos({
    int limit = 5,
    DocumentSnapshot? startAfter,
  });
  Future<DocumentSnapshot?> getLastDocument(String videoId);
  // Вообще теперь когда все удаляется после какого-то раза, то может оно и не надо
  Future<void> cacheVideos(List<Video> videos);
  Future<List<Video>> getCachedVideos({int limit = 5});
  Future<void> clearCache();
} 