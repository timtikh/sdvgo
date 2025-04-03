import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';

class Photo extends StatefulWidget {
  const Photo({super.key});

  @override
  State<Photo> createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  late CameraController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _controller = CameraController(frontCamera, ResolutionPreset.medium);

    try {
      await _controller.initialize();
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      // Handle camera initialization error
      debugPrint('Error initializing camera: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const SizedBox(
        width: 120,
        height: 120,
        child: DecoratedBox(
          decoration: BoxDecoration(color: Colors.grey),
        ),
      );
    }

    return SizedBox(
      width: 120,
      height: 120,
      child: ClipRect(
        child: Transform.scale(
          scale: 1.0,
          child: Center(
            child: CameraPreview(_controller),
          ),
        ),
      ),
    );
  }
}
