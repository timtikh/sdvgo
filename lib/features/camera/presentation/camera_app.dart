import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';

import '../../../main.dart';

class CameraApp extends StatefulWidget {
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;
  Offset? assetPosition;
  bool isDragging = false;

  @override
  void initState() {
    super.initState();

    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    controller = CameraController(frontCamera, ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Image(
          image: AssetImage('assets/images/sad_fish(maybe).jpeg'));
    }
    return GestureDetector(
      onDoubleTap: () => {},
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Transform.flip(flipX: true, child: CameraPreview(controller)),
              StrokeText(
                text: 'DO I BELONG HERE?\n'
                    '\nWILL I FIND WHAT I SEEK?\n'
                    '\nAM I AT THE RIGHT PLACE?\n'
                    '\n AM I DOING THE RIGHT THING?\n'
                    '\n AM I A RIGHT PERSON?',
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 22, // Adjust size as needed
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Chococooky',
                ),
                strokeColor: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
