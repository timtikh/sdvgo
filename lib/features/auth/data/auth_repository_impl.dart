import 'package:firebase_auth/firebase_auth.dart' hide UserInfo;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sdvgo/core/domain/user_info.dart';
import 'package:sdvgo/features/auth/domain/repositories/auth_repository.dart';
import 'package:sdvgo/features/auth/exceptions/auth_exception.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  User? dataUser;
  UserInfo? domainUser;

  AuthRepositoryImpl({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn() {
    dataUser = _firebaseAuth.currentUser;

    // TODO: тут dataUser может быть null. не уверен, что делаю правильно когда ставлю там ?
    domainUser = UserInfo(email: dataUser?.email, uid: dataUser?.uid);
  }

  // TODO: опять же тут info может быть null, наверное так надо
  @override
  UserInfo? get currentUserInfo => domainUser;

  // TODO: я возвращаю объект User который из файербейза. должно быть иначе.
  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  Future<void> signInWithGoogle() async {
    try {
      final currentUser = _googleSignIn.currentUser;
      if (currentUser != null) {
        await _googleSignIn.signOut();
      }

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw AuthException(message: 'Google sign in was cancelled by user');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        throw AuthException(message: 'Failed to get Google auth tokens');
      }

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseException catch (e) {
      throw AuthException(
        message: e.message ?? 'Unknown Firebase error during Google sign in',
      );
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      throw AuthException(message: 'Error signing out: ${e.toString()}');
    }
  }
}
