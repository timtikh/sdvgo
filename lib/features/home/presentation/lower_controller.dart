import 'package:flutter/material.dart';

// TODO: он типо должен хэндлить логику переключения между списком вижетов
// TODO:  а в идеале вообще быть унаследован от одного и того же типа

class LowerController extends StatefulWidget {
  const LowerController({super.key});

  @override
  State<LowerController> createState() => _LowerControllerState();
}

class _LowerControllerState extends State<LowerController> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.green.shade100,);
  }
}
