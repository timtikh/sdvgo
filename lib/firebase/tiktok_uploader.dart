import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

// ОГРОМНЫЙ КОСТЫЛЬ ПО ЗАГРУЗКЕ МНОЖЕСТВА ЭКЗЕМПЛЯРОВ В КОЛЛЕКЦИЮ
// GPT GENERATED but working

class TikTokUploader {
  static Future<void> uploadTikToks() async {
    try {
      await Firebase.initializeApp();

      final String jsonString =
          await rootBundle.loadString('assets/tiktoks.json');
      final Map<String, dynamic> jsonData =
          json.decode(jsonString) as Map<String, dynamic>;
      final List<dynamic> tiktoks = jsonData['tiktoks'] as List<dynamic>;

      final CollectionReference tiktokCollection =
          FirebaseFirestore.instance.collection('tiktok_collection_1');

      WriteBatch batch = FirebaseFirestore.instance.batch();

      for (final tiktok in tiktoks) {
        final item = tiktok as Map<String, dynamic>;
        final docRef = tiktokCollection.doc(item['id'].toString());

        batch.set(docRef, {
          ...item,
          'timestamp': FieldValue.serverTimestamp(),
          'likesCount': int.tryParse(
                  item['likes'].toString().replaceAll(RegExp(r'[^0-9]'), '')) ??
              0,
        });
      }

      await batch.commit();
      print('🔥 Successfully uploaded ${tiktoks.length} TikToks!');
    } catch (e) {
      print('❌ Error uploading TikToks: $e');
      rethrow;
    }
  }
}
