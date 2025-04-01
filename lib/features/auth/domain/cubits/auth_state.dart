part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final AuthStatus status;
  final UserInfo? user;
  final String? errorMessage;

  const AuthState._({
    required this.status,
    this.user,
    this.errorMessage,
  });

  const AuthState.initial() : this._(status: AuthStatus.initial);

  const AuthState.loading() : this._(status: AuthStatus.loading);

  const AuthState.authenticated(UserInfo user)
      : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  AuthState.error(String message)
      : this._(status: AuthStatus.error, errorMessage: message);

  bool get isAuthenticated =>
      status == AuthStatus.authenticated && user != null;
  bool get isLoading => status == AuthStatus.loading;
  bool get hasError => status == AuthStatus.error;

  @override
  List<Object?> get props => [status, user, errorMessage];
}

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}
