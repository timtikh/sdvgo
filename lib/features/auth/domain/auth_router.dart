import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdvgo/core/di/app_scope.dart';
import 'package:sdvgo/features/auth/domain/cubits/auth_cubit.dart';
import 'package:sdvgo/features/auth/presentation/pages/login_page.dart';
import 'package:sdvgo/features/home/home_page.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class AuthRouter extends StatelessWidget {
  const AuthRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopeBuilder<AppScopeContainer>.withPlaceholder(
      builder: (context, scope) {
        final authCubit = scope.authCubitDep.get;

        return BlocBuilder<AuthCubit, AuthState>(
          bloc: authCubit,
          builder: (context, state) {
            if (state.isAuthenticated) {
              return const HomePage();
            }

            // Show loading indicator during initial app load
            if (state.status == AuthStatus.initial || state.isLoading) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            return const LoginPage();
          },
        );
      },
    );
  }
}
