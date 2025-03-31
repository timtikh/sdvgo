import 'package:flutter/material.dart';
import 'package:sdvgo/core/presentation/swiping_container.dart';

// TODO: он типо должен хэндлить логику переключения между списком вижетов
// TODO:  а в идеале вообще быть унаследован от одного и того же типа

class UpperController extends StatefulWidget {
  const UpperController({super.key});

  @override
  State<UpperController> createState() => _UpperControllerState();
}

class _UpperControllerState extends State<UpperController> {
  List<Widget> children = List.generate(4, (i) {
    return ColoredBox(
      color: Colors.pink.shade100,
      child: Center(child: Text('$i')),
    );
  });

  @override
  Widget build(BuildContext context) {
    return SwipingContainer(children: children);
  }
}
