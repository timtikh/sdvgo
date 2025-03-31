import 'package:sdvgo/core/domain/user_info.dart';

abstract class AuthRepository {
  Stream<UserInfo?> get authStateChanges;
  UserInfo? get currentUserInfo;

  Future<void> signInWithGoogle();
  Future<void> signOut();
}
