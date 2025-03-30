import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'user.dart';

class UserCubit extends Cubit<User> {
  UserCubit({
    required int score,
    required int tiktokCount,
    required String name,
    required String surname,
  }) : super(User(
          score: score,
          tiktokCount: tiktokCount,
          name: name,
          surname: surname,
        ));

  void incrementScore() => emit(state.copyWith(score: state.score + 1));

  void incrementTiktokCount() =>
      emit(state.copyWith(tiktokCount: state.tiktokCount + 1));

  void setScore(int newScore) => emit(state.copyWith(score: newScore));

  void setTiktokCount(int newTiktokCount) =>
      emit(state.copyWith(tiktokCount: newTiktokCount));

  void setName(String newName) => emit(state.copyWith(name: newName));

  void setSurname(String newSurname) =>
      emit(state.copyWith(surname: newSurname));
}
