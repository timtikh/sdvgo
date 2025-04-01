import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdvgo/core/di/app_scope.dart';
import 'package:sdvgo/features/auth/domain/cubits/auth_cubit.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

import '../widgets/animated_logo.dart';
import '../widgets/animated_welcome_text.dart';
import '../widgets/google_sign_in_roulette.dart';
import '../widgets/trash_background.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopeBuilder<AppScopeContainer>.withPlaceholder(
      builder: (context, scope) {
        final authCubit = scope.authCubitDep.get;

        return BlocListener<AuthCubit, AuthState>(
          bloc: authCubit,
          listener: (context, state) {
            if (state.isAuthenticated) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (state.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Authentication error: ${state.errorMessage}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: TrashBackground(
            child: BlocBuilder<AuthCubit, AuthState>(
              bloc: authCubit,
              builder: (context, state) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedLogo(
                        text: 'SDVGO',
                        fadeAnimation: _fadeAnimation,
                      ),
                      SizedBox(height: 40),
                      state.isLoading
                          ? CircularProgressIndicator()
                          : GoogleSignInRoulette(
                              onLuckyButtonPressed: () {
                                authCubit.signInWithGoogle();
                              },
                            ),
                      SizedBox(height: 20),
                      AnimatedWelcomeText(
                        text: 'Суперапп для зумеров!',
                        fadeAnimation: _fadeAnimation,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
