import 'package:flutter/material.dart';
import 'package:sdvgo/core/presentation/dialog_window.dart';
import 'package:sdvgo/core/presentation/gradient_background.dart';
import 'package:sdvgo/features/home/presentation/clicker_button.dart';
import 'package:sdvgo/features/home/presentation/draggable_bottom_sheet.dart';
import 'package:sdvgo/features/home/presentation/lower_controller.dart';
import 'package:sdvgo/features/home/presentation/upper_controller.dart';
import 'package:shake_gesture/shake_gesture.dart';

import 'presentation/control_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool _isDialogShowing = false;
  bool _isBottomSheetVisible = false;
  final _bottomSheetController = DraggableScrollableController();
  bool _isCurrentRoute = true;

  // Animation controller
  late AnimationController _opacityController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _bottomSheetController.addListener(_onBottomSheetChanged);

    // Initialize animation controller
    _opacityController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_opacityController);

    // Add navigation observer
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkIfCurrentRoute();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkIfCurrentRoute();
  }

  void _checkIfCurrentRoute() {
    final route = ModalRoute.of(context);
    if (route != null) {
      setState(() {
        _isCurrentRoute = route.isCurrent;
      });
    }
  }

  @override
  void dispose() {
    _bottomSheetController.removeListener(_onBottomSheetChanged);
    _bottomSheetController.dispose();
    _opacityController.dispose();
    super.dispose();
  }

  void _onBottomSheetChanged() {
    if (_bottomSheetController.size <= 0.1) {
      setState(() {
        _isBottomSheetVisible = false;
      });
    } else if (_bottomSheetController.size >= 0.5) {
      setState(() {
        _isBottomSheetVisible = true;
      });
    }
  }

  void _showBottomSheet() {
    setState(() {
      _isBottomSheetVisible = true;
      _bottomSheetController.animateTo(
        0.2,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _showVapeDialog() {
    // Only show dialog if this is the current route and dialog is not already showing
    if (_isCurrentRoute && !_isDialogShowing) {
      _isDialogShowing = true;
      showDialog(
        context: context,
        builder: (context) => DialogWindow.withButtons(
          dialogText: "Причина тряски?",
          buttonTexts: ["Повейпить", "Настройки"],
          buttonOnTaps: [
            () {
              Navigator.pop(context);
              _isDialogShowing = false;
              _showBottomSheet();
            },
            () {
              Navigator.pop(context);
              _isDialogShowing = false;
              Navigator.pushNamed(context, "/userinfo").then((_) {
                // Check route status when returning from navigation
                _checkIfCurrentRoute();
              });
            },
          ],
          buttonTextColor: Colors.yellow,
          buttonBorderColor: Colors.red,
          buttonBgColor: Colors.green,
        ),
      ).then((_) {
        _isDialogShowing = false;
      });
    }
  }

  // Method to handle button press animation
  void animateOpacity(bool pressed) {
    if (pressed) {
      _opacityController.animateTo(1.0);
    } else {
      _opacityController.animateTo(0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Update current route status on build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkIfCurrentRoute();
    });

    return Stack(
      children: [
        Scaffold(
          body: GradientBackground(
            child: SafeArea(
              child: ShakeGesture(
                onShake: _showVapeDialog,
                child: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.loose,
                  children: [
                    _buildMainContent(),
                    ClickerButton(),
                    if (_isBottomSheetVisible)
                      DraggableBottomSheetWidget(
                        controller: _bottomSheetController,
                        onButtonPressed: animateOpacity,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _opacityController,
          builder: (context, child) {
            return IgnorePointer(
              child: ColoredBox(
                color: Colors.grey.withOpacity(_opacityAnimation.value),
                child: SizedBox.expand(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        Expanded(flex: 8, child: UpperController()),
        Expanded(
          flex: 1,
          child: ControlBar(),
        ),
        Expanded(flex: 8, child: LowerController()),
      ],
    );
  }
}
