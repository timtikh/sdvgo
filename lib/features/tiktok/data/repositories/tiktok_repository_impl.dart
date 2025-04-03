import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repositories/tiktok_repository.dart';
import '../../domain/video.dart';

class TikTokRepositoryImpl implements TikTokRepository {
  final FirebaseFirestore _firestore;
  static const String _collectionName = 'tiktok_collection_1';

  TikTokRepositoryImpl(this._firestore);

  @override
  Future<List<Video>> getVideos({
    int limit = 5,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      var query = _firestore
          .collection(_collectionName)
          .orderBy('id', descending: true)
          .limit(limit);

      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }

      final snapshot = await query.get();

      if (snapshot.docs.isEmpty) {
        print('No documents found in collection $_collectionName');
      }

      return snapshot.docs.map((doc) {
        return Video.fromJson(doc.data());
      }).toList();
    } catch (e) {
      print('Firestore error: $e');
      throw Exception('Failed to fetch videos: $e');
    }
  }

  @override
  Future<DocumentSnapshot?> getLastDocument(String videoId) async {
    try {
      final doc =
          await _firestore.collection(_collectionName).doc(videoId).get();
      return doc.exists ? doc : null;
    } catch (e) {
      print('Firestore error: $e');
      return null;
    }
  }

  // УДАЛЯЮ? кэшить не надо вроде
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
    return getVideos(limit: limit);
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
