import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repositories/tiktok_repository.dart';
import '../../domain/video.dart';

class TikTokRepositoryImpl implements TikTokRepository {
  final FirebaseFirestore _firestore;
  static const String _collectionName = 'tiktok_collection_1';

  TikTokRepositoryImpl(this._firestore);

  Future<List<Video>> getVideos({int limit = 10, int offset = 0}) async {
    try {
      final snapshot = await _firestore
          .collection(_collectionName)
          .limit(limit)
          .get();

      if (snapshot.docs.isEmpty) {
        print('No documents found in collection $_collectionName');
      }

      return snapshot.docs.map((doc) {
        print('Document data: ${doc.data()}'); // Debug print
        return Video.fromJson(doc.data());
      }).toList();
    } catch (e) {
      print('Firestore error: $e'); // More detailed error
      throw Exception('Failed to fetch videos: $e');
    }
  }

  @override
  Future<void> cacheVideos(List<Video> videos) async {
    try {
      // TODO: caching
    } catch (e) {
      throw Exception('Failed to cache videos: $e');
    }
  }

  @override
  Future<List<Video>> getCachedVideos({int limit = 10, int offset = 0}) async {
    // TODO: caching
    return getVideos(limit: limit, offset: offset);
  }

  @override
  Future<void> clearCache() async {
    try {
      // TODO: caching
    } catch (e) {
      throw Exception('Failed to clear cache: $e');
    }
  }
}
