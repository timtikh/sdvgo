import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sdvgo/core/domain/user_info.dart';
import 'package:sdvgo/features/auth/domain/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  late final StreamSubscription<UserInfo?> _authStateSubscription;

  AuthCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState.initial()) {
    _init();
  }

  void _init() {
    _authStateSubscription =
        _authRepository.authStateChanges.listen((userInfo) {
      if (userInfo != null) {
        emit(AuthState.authenticated(userInfo));
      } else {
        emit(const AuthState.unauthenticated());
      }
    });
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(const AuthState.loading());
      await _authRepository.signInWithGoogle();
      // Auth state will be updated by the stream listener
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      emit(const AuthState.loading());
      await _authRepository.signOut();
      // Auth state will be updated by the stream listener
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _authStateSubscription.cancel();
    return super.close();
  }
}
