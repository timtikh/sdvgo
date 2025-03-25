import 'package:flutter/material.dart';

// TODO: он типо должен хэндлить логику переключения между списком вижетов
// TODO:  а в идеале вообще быть унаследован от одного и того же типа

class UpperController extends StatefulWidget {
  const UpperController({super.key});

  @override
  State<UpperController> createState() => _UpperControllerState();
}

class _UpperControllerState extends State<UpperController> {
  @override
  Widget build(BuildContext context) {
    return Container(color:Colors.pink.shade100,);
  }
}
