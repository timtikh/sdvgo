import 'package:bloc/bloc.dart';

import 'user_statistics.dart';

class UserStatisticsCubit extends Cubit<UserStatistics> {
  UserStatisticsCubit({
    required int clicksCount,
    required int tiktokCount,
    required int puffs,
    required int gamePoints,
  }) : super(UserStatistics(
          clicksCount: clicksCount,
          tiktokCount: tiktokCount,
          puffs: puffs,
          gamePoints: gamePoints,
        ));

  void increaseClicksCountByValue(int value) =>
      emit(state.copyWith(clicksCount: state.clicksCount + value));

  void increaseTiktokCountByValue(int value) =>
      emit(state.copyWith(tiktokCount: state.tiktokCount + value));

  void increasePuffsByValue(int value) =>
      emit(state.copyWith(puffs: state.puffs + value));

  void increaseGamePointsByValue(int value) =>
      emit(state.copyWith(gamePoints: state.gamePoints + value));

  void setClicksCount(int newClicksCount) =>
      emit(state.copyWith(clicksCount: newClicksCount));

  void setTiktokCount(int newTiktokCount) =>
      emit(state.copyWith(tiktokCount: newTiktokCount));

  void setPuffs(int newPuffs) => emit(state.copyWith(puffs: newPuffs));

  void setGamePoints(int newGamePoints) =>
      emit(state.copyWith(gamePoints: newGamePoints));
}
