import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sdvgo/features/tiktok/data/repositories/tiktok_repository_impl.dart';
import 'package:sdvgo/features/tiktok/presentation/tiktok_screen.dart';
import 'dart:core';

import '../../tiktok/domain/cubit/tiktok_cubit.dart'; // For using URIs

// TODO: он типо должен хэндлить логику переключения между списком вижетов
// TODO:  а в идеале вообще быть унаследован от одного и того же типа

class UpperController extends StatefulWidget {
  const UpperController({super.key});

  @override
  State<UpperController> createState() => _UpperControllerState();
}

class _UpperControllerState extends State<UpperController> {
  late final TikTokRepositoryImpl _repository;

  @override
  void initState() {
    super.initState();
    _repository = TikTokRepositoryImpl(FirebaseFirestore.instance);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade100,
      child: BlocProvider(
        create: (_) => TikTokCubit(_repository),
        child: const TikTokScreen(),
      ),
    );
  }
}