import 'package:firebase_auth/firebase_auth.dart' hide UserInfo;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sdvgo/core/domain/user_info.dart';
import 'package:sdvgo/features/auth/domain/repositories/auth_repository.dart';
import 'package:sdvgo/features/auth/exceptions/auth_exception.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepositoryImpl({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  UserInfo? get currentUserInfo {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;

    return UserInfo(
      uid: user.uid,
      email: user.email,
    );
  }

  @override
  Stream<UserInfo?> get authStateChanges =>
      _firebaseAuth.authStateChanges().map((user) =>
          user != null ? UserInfo(uid: user.uid, email: user.email) : null);

  @override
  Future<void> signInWithGoogle() async {
    try {
      // Check if there's an ongoing sign-in process
      final currentUser = _googleSignIn.currentUser;
      if (currentUser != null) {
        await _googleSignIn.signOut();
      }

      // Start the sign-in process
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw AuthException(message: 'Google sign in was cancelled by user');
      }

      // Get the auth details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        throw AuthException(message: 'Failed to get Google auth tokens');
      }

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        message: e.message ?? 'Unknown Firebase error during Google sign in',
      );
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException(
          message: 'Error signing in with Google: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      throw AuthException(message: 'Error signing out: ${e.toString()}');
    }
  }
}
