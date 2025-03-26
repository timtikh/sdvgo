import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  int _score;
  int _tiktokCount;
  String _name;
  String _surname;

  int get score => _score;
  int get tiktokCount => _tiktokCount;
  String get name => _name;
  String get surname => _surname;

  // Тоже не оч нравится этот блок
  void incrementScore() {
    _score++;
    notifyListeners();
  }

  void incrementTiktokCount() {
    _tiktokCount++;
    notifyListeners();
  }

  void setScore(int newScore) {
    _score = newScore;
    notifyListeners();
  }

  void setTiktokCount(int newTiktokCount) {
    _tiktokCount = newTiktokCount;
    notifyListeners();
  }

  void setName(String newName) {
    _name = newName;
    notifyListeners();
  }

  void setSurname(String newSurname) {
    _surname = newSurname;
    notifyListeners();
  }

  UserModel({
    required int score,
    required int tiktokCount,
    required String name,
    required String surname,
  })  : _score = score,
        _tiktokCount = tiktokCount,
        _name = name,
        _surname = surname;
}