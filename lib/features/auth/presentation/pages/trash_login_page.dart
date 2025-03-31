import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdvgo/core/di/app_scope.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

import '../../domain/auth_provider.dart';
import '../widgets/animated_logo.dart';
import '../widgets/animated_welcome_text.dart';
import '../widgets/google_sign_in_roulette.dart';
import '../widgets/trash_background.dart';

class TrashLoginPage extends StatefulWidget {
  const TrashLoginPage({Key? key}) : super(key: key);

  @override
  State<TrashLoginPage> createState() => _TrashLoginPageState();
}

class _TrashLoginPageState extends State<TrashLoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool _isLoading = false;

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
    final authService = Provider.of<AuthenticationProvider>(context);

    return ScopeBuilder<AppScopeContainer>.withPlaceholder(
      builder: (context, scope) {
        // final authRepository = scope.authRepositoryDep.get;

        return TrashBackground(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedLogo(
                  text: 'SDVGO',
                  fadeAnimation: _fadeAnimation,
                ),
                SizedBox(height: 40),
                _isLoading
                    ? CircularProgressIndicator()
                    : GoogleSignInRoulette(
                        onLuckyButtonPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          try {
                            await authService.signInWithGoogle();
                            // await authRepository.signInWithGoogle();
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Failed to sign in: $e'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          } finally {
                            if (mounted) {
                              setState(() {
                                _isLoading = false;
                              });
                              if (authService.authState != null) {
                                Navigator.pushNamed(context, '/home');
                              }
                              // if (authRepository.authStateChanges != null) {
                              //   Navigator.pushNamed(context, '/home');
                              // }
                            }
                          }
                        },
                      ),
                SizedBox(height: 20),
                AnimatedWelcomeText(
                  // todo: add locales
                  text: 'Суперапп для зумеров!',
                  fadeAnimation: _fadeAnimation,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
