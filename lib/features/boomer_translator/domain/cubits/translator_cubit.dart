import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sdvgo/features/boomer_translator/domain/repositories/translator_repository.dart';

part 'translator_state.dart';

class TranslatorCubit extends Cubit<TranslatorState> {
  final TranslatorRepository _translatorRepository;

  TranslatorCubit({required TranslatorRepository translatorRepository})
      : _translatorRepository = translatorRepository,
        super(const TranslatorState.initial()) {
    _init();
  }

  void _init() {}

  Future<void> requestTranslation(String boomerMessage) async {
    try {
      emit(const TranslatorState.loading());
      final zoomerMessage =
          await _translatorRepository.translate(boomerMessage);
      emit(TranslatorState.withResponse(zoomerMessage));
      // Auth state will be updated by the stream listener
    } catch (e) {
      emit(TranslatorState.error(e.toString()));
    }
  }
}
