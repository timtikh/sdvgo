import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  int _score = 0;
  int _tiktokCount = 0;
  String _name = 'Jane';
  String _surname = 'Doe';

  int get score => _score;
  int get tiktokCount => _tiktokCount;
  String get name => _name;
  String get surname => _surname;

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
    int score = 0,
    int tiktokCount = 0,
    String name = 'Jane',
    String surname = 'Doe',
  })  : _score = score,
        _tiktokCount = tiktokCount,
        _name = name,
        _surname = surname;
}