import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sdvgo/core/domain/user_statistics_cubit.dart';
import 'package:sdvgo/features/auth/data/auth_repository_impl.dart';
import 'package:sdvgo/features/auth/domain/cubits/auth_cubit.dart';
import 'package:sdvgo/features/auth/domain/repositories/auth_repository.dart';
import 'package:sdvgo/features/tiktok/data/repositories/tiktok_repository_impl.dart';
import 'package:sdvgo/features/tiktok/domain/cubit/tiktok_cubit.dart';
import 'package:sdvgo/features/tiktok/domain/repositories/controller_repository.dart';
import 'package:sdvgo/features/tiktok/domain/repositories/tiktok_repository.dart';
import 'package:yx_scope/yx_scope.dart';

import '../../features/tiktok/presentation/controller_repository_impl.dart';

class AppScopeContainer extends ScopeContainer {
  // TODO: надо чето сделать с тем что я нулями просто инициализирую значения
  late final userStatisticsCubitDep = dep(() => UserStatisticsCubit(
      clicksCount: 0, tiktokCount: 0, puffs: 0, gamePoints: 0));

  late final authRepositoryDep =
      dep<AuthRepository>(() => AuthRepositoryImpl());

  late final authCubitDep =
      dep(() => AuthCubit(authRepository: authRepositoryDep.get));

  /// tiktok section
  late final tiktokRepositoryDep =
    dep<TikTokRepository>(() => TikTokRepositoryImpl(FirebaseFirestore.instance));

  late final tiktokCubitDep =
    dep(() => TikTokCubit(tiktokRepositoryDep.get));

  /*late final tiktokControllerRepositoryDep =
    dep<TiktokControllerRepository>(() => TiktokControllerRepositoryImpl(tiktokCubitDep.get));
*/
  /// tiktok section end
}

class AppScopeHolder extends ScopeHolder<AppScopeContainer> {
  static const _listener = AppListener();

  AppScopeHolder()
      : super(scopeListeners: [_listener], depListeners: [_listener]);

  @override
  AppScopeContainer createContainer() => AppScopeContainer();
}

class AppListener implements ScopeListener, DepListener {
  const AppListener();

  static void _log(
    String message, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    print(message);
    if (exception != null) {
      print(exception);
      if (stackTrace != null) {
        print(stackTrace);
      }
    }
  }

  @override
  void onScopeStartInitialize(ScopeId scope) =>
      _log('[$scope] -> onScopeStartInitialize');

  @override
  void onScopeInitialized(ScopeId scope) =>
      _log('[$scope] -> onScopeInitialized');

  @override
  void onScopeInitializeFailed(
    ScopeId scope,
    Object exception,
    StackTrace stackTrace,
  ) =>
      _log('[$scope] -> onScopeInitializeFailed', exception, stackTrace);

  @override
  void onScopeStartDispose(ScopeId scope) =>
      _log('[$scope] -> onScopeStartDispose');

  @override
  void onScopeDisposed(ScopeId scope) => _log('[$scope] -> onScopeDisposed');

  @override
  void onScopeDisposeDepFailed(
    ScopeId scope,
    DepId dep,
    Object exception,
    StackTrace stackTrace,
  ) =>
      _log('[$scope] -> onScopeDisposeDepFailed', exception, stackTrace);

  @override
  void onValueStartCreate(ScopeId scope, DepId dep) =>
      _log('[$scope.$dep] -> onValueStartCreate');

  @override
  void onValueCreated(ScopeId scope, DepId dep, ValueMeta? valueMeta) =>
      _log('[$scope.$dep] -> onValueCreated');

  @override
  void onValueCreateFailed(
    ScopeId scope,
    DepId dep,
    Object exception,
    StackTrace stackTrace,
  ) =>
      _log('[$scope.$dep] -> onValueCreated', exception, stackTrace);

  @override
  void onValueCleared(ScopeId scope, DepId dep, ValueMeta? valueMeta) =>
      _log('[$scope.$dep]($valueMeta) -> onValueCleared');
}
