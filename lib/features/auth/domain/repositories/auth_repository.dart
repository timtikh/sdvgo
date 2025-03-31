import 'package:firebase_auth/firebase_auth.dart' hide UserInfo;
import 'package:sdvgo/core/domain/user_info.dart';

abstract class AuthRepository {
  Stream<User?> get authStateChanges;
  UserInfo? get currentUserInfo;

  Future<void> signInWithGoogle();
  Future<void> signOut();
}
