// auth_provider.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class AuthenticationProvider {
  final FirebaseAuth firebaseAuth;
  //FirebaseAuth instance
  AuthenticationProvider(this.firebaseAuth);

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get user => firebaseAuth.currentUser;
  Stream<User?> get authState => firebaseAuth.idTokenChanges();


  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseException catch (e) {
      throw Exception('${e.message}');
    }
  }

  Future<void> registerWithEmailAndPassword(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseException catch (e) {
      throw Exception('${e.message}');
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      // First, check if there's an ongoing sign-in process
      final currentUser = _googleSignIn.currentUser;
      if (currentUser != null) {
        await _googleSignIn.signOut();
      }

      // Start the sign-in process
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google sign in was cancelled by user');
      }

      // Get the auth details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        throw Exception('Failed to get Google auth tokens');
      }

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      await firebaseAuth.signInWithCredential(credential);
    } on FirebaseException catch (e) {
      throw Exception('Firebase error: ${e.message ?? 'Unknown Firebase error'}');
    } on Exception catch (e) {
      throw Exception('Error signing in with Google: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      throw Exception('Error signing out: ${e.toString()}');
    }
  }
}