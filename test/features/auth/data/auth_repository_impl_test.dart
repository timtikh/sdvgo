// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sdvgo/features/auth/data/auth_repository_impl.dart';
import 'package:sdvgo/features/auth/exceptions/auth_exception.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

class GoogleSignInMock extends Mock implements GoogleSignIn {}

void main() {
  group(
    '$AuthRepositoryImpl',
    () {
      final firebaseAuth = FirebaseAuthMock();
      final googleSignIn = GoogleSignInMock();

      late AuthRepositoryImpl authRepositoryImpl;

      setUp(
        () {
          authRepositoryImpl = AuthRepositoryImpl(
            firebaseAuth: firebaseAuth,
            googleSignIn: googleSignIn,
          );
        },
      );

      tearDown(
        () {
          reset(firebaseAuth);
          reset(googleSignIn);
        },
      );

      group(
        'SignOut',
        () {
          test(
            'Success',
            () async {
              when(firebaseAuth.signOut).thenAnswer(
                (_) async {},
              );
              when(googleSignIn.signOut).thenAnswer(
                (_) => Future.value(null),
              );
              await expectLater(
                  () => authRepositoryImpl.signOut(), returnsNormally);
            },
          );
          group(
            'Errors',
            () {
              test(
                'Error in firebaseAuth',
                () async {
                  when(firebaseAuth.signOut).thenThrow(
                    (_) async {
                      return Exception();
                    },
                  );
                  when(googleSignIn.signOut).thenAnswer(
                    (_) => Future.value(null),
                  );
                  await expectLater(
                    () => authRepositoryImpl.signOut(),
                    throwsA(
                      isA<AuthException>(),
                    ),
                  );
                },
              );
              test(
                'Error in googleSignIn',
                () async {
                  when(firebaseAuth.signOut).thenAnswer(
                    (_) async {},
                  );
                  when(googleSignIn.signOut).thenThrow(
                    (_) {
                      return Exception();
                    },
                  );
                  await expectLater(() => authRepositoryImpl.signOut(),
                      throwsA(isA<AuthException>()));
                },
              );
              test(
                'Error in firebaseAuth and googleSignIn',
                () async {
                  when(firebaseAuth.signOut).thenThrow(
                    (_) async {
                      return Exception();
                    },
                  );
                  when(googleSignIn.signOut).thenThrow(
                    (_) {
                      return Exception();
                    },
                  );
                  await expectLater(() => authRepositoryImpl.signOut(),
                      throwsA(isA<AuthException>()));
                },
              );
            },
          );
        },
      );
    },
  );
}
